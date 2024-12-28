return {
	"stevearc/oil.nvim",
	enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")

		oil.setup({
			default_file_explorer = false,
			columns = { "icon" },
			keymaps = {
				["<C-p>"] = false,
				["-"] = false,
				["h"] = "actions.parent",
				["l"] = "actions.select",
				["u"] = "actions.parent",
			},
			view_options = {
				show_hidden = true,
			},
			-- EXPERIMENTAL support for performing file operations with git
			git = {
				-- Return true to automatically git add/mv/rm files
				add = function(path)
					return false
				end,
				mv = function(src_path, dest_path)
					return true
				end,
				rm = function(path)
					return true
				end,
			},
		})

		-- Open parent directory in current window
		vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>")

		-- Open parent directory in floating window
		vim.keymap.set("n", "<space><Up>", oil.toggle_float)
	end,
}
