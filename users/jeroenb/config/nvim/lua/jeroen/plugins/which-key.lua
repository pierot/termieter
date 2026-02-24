return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			delay = 300,
			icons = {
				mappings = false,
			},
		})

		wk.add({
			{ "<leader>c", group = "copy/code" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>l", group = "lazy" },
			{ "<leader>r", group = "rename/restart" },
			{ "<leader>t", group = "test" },
			{ "<leader>h", group = "git hunks" },
			{ "<leader>x", group = "trouble" },
			{ "<leader>n", group = "swap next" },
			{ "<leader>p", group = "swap prev" },
		})
	end,
}
