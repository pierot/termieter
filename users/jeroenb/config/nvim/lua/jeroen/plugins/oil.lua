return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")

		oil.setup({
			columns = { "icon" },
			keymaps = {
				["<C-p>"] = false,
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
		vim.keymap.set("n", "-", "<CMD>Oil<CR>")

		-- Open parent directory in floating window
		vim.keymap.set("n", "<space>-", oil.toggle_float)
	end,
}
