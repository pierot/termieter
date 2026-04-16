return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")

		local function map_select(keys, query, desc)
			vim.keymap.set({ "x", "o" }, keys, function()
				select.select_textobject(query, "textobjects")
			end, { desc = desc })
		end

		-- assignment
		map_select("a=", "@assignment.outer", "outer assignment")
		map_select("i=", "@assignment.inner", "inner assignment")
		map_select("l=", "@assignment.lhs", "lhs assignment")
		map_select("r=", "@assignment.rhs", "rhs assignment")
		-- property
		map_select("a:", "@property.outer", "outer property")
		map_select("i:", "@property.inner", "inner property")
		map_select("l:", "@property.lhs", "lhs property")
		map_select("r:", "@property.rhs", "rhs property")
		-- parameter
		map_select("aa", "@parameter.outer", "outer parameter")
		map_select("ia", "@parameter.inner", "inner parameter")
		-- conditional
		map_select("ai", "@conditional.outer", "outer conditional")
		map_select("ii", "@conditional.inner", "inner conditional")
		-- loop
		map_select("al", "@loop.outer", "outer loop")
		map_select("il", "@loop.inner", "inner loop")
		-- call
		map_select("af", "@call.outer", "outer call")
		map_select("if", "@call.inner", "inner call")
		-- function/method definition
		map_select("am", "@function.outer", "outer function")
		map_select("im", "@function.inner", "inner function")
		-- class
		map_select("ac", "@class.outer", "outer class")
		map_select("ic", "@class.inner", "inner class")

		-- swap
		vim.keymap.set("n", "<leader>na", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "swap next parameter" })
		vim.keymap.set("n", "<leader>n:", function()
			swap.swap_next("@property.outer")
		end, { desc = "swap next property" })
		vim.keymap.set("n", "<leader>nm", function()
			swap.swap_next("@function.outer")
		end, { desc = "swap next function" })
		vim.keymap.set("n", "<leader>pa", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "swap prev parameter" })
		vim.keymap.set("n", "<leader>p:", function()
			swap.swap_previous("@property.outer")
		end, { desc = "swap prev property" })
		vim.keymap.set("n", "<leader>pm", function()
			swap.swap_previous("@function.outer")
		end, { desc = "swap prev function" })

		-- move
		local function map_move(dir, keys, query, group, desc)
			vim.keymap.set({ "n", "x", "o" }, keys, function()
				move[dir](query, group or "textobjects")
			end, { desc = desc })
		end

		map_move("goto_next_start", "]f", "@call.outer", nil, "next call start")
		map_move("goto_next_start", "]m", "@function.outer", nil, "next function start")
		map_move("goto_next_start", "]i", "@conditional.outer", nil, "next conditional start")
		map_move("goto_next_start", "]l", "@loop.outer", nil, "next loop start")
		map_move("goto_next_start", "]s", "@local.scope", "locals", "next scope")
		map_move("goto_next_start", "]z", "@fold", "folds", "next fold")

		map_move("goto_next_end", "]F", "@call.outer", nil, "next call end")
		map_move("goto_next_end", "]M", "@function.outer", nil, "next function end")
		map_move("goto_next_end", "]C", "@class.outer", nil, "next class end")
		map_move("goto_next_end", "]I", "@conditional.outer", nil, "next conditional end")
		map_move("goto_next_end", "]L", "@loop.outer", nil, "next loop end")

		map_move("goto_previous_start", "[f", "@call.outer", nil, "prev call start")
		map_move("goto_previous_start", "[m", "@function.outer", nil, "prev function start")
		map_move("goto_previous_start", "[i", "@conditional.outer", nil, "prev conditional start")
		map_move("goto_previous_start", "[l", "@loop.outer", nil, "prev loop start")

		map_move("goto_previous_end", "[F", "@call.outer", nil, "prev call end")
		map_move("goto_previous_end", "[M", "@function.outer", nil, "prev function end")
		map_move("goto_previous_end", "[C", "@class.outer", nil, "prev class end")
		map_move("goto_previous_end", "[I", "@conditional.outer", nil, "prev conditional end")
		map_move("goto_previous_end", "[L", "@loop.outer", nil, "prev loop end")
	end,
}
