return { -- pretty lsp diagnostics
	"folke/trouble.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("trouble").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		})

		-- Lua
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>xx", function()
			require("trouble").toggle()
		end)
		keymap.set("n", "<leader>xw", function()
			require("trouble").toggle("workspace_diagnostics")
		end)
		keymap.set("n", "<leader>xd", function()
			require("trouble").toggle("document_diagnostics")
		end)
		keymap.set("n", "<leader>xq", function()
			require("trouble").toggle("quickfix")
		end)
		keymap.set("n", "<leader>xl", function()
			require("trouble").toggle("loclist")
		end)
		keymap.set("n", "gR", function()
			require("trouble").toggle("lsp_references")
		end)
	end,
}
