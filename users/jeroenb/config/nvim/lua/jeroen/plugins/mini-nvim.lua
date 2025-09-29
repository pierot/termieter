return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		-- extend and create a/i textobjects
		require("mini.ai").setup()
		-- autopairs
		require("mini.pairs").setup()
		require("mini.align").setup({
			mappings = {
				start = "gva",
				start_with_preview = "gvA",
			},
		})
		require("mini.icons").setup()
		require("mini.surround").setup()
	end,
}
