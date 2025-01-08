return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		-- extend and create a/i textobjects
		require("mini.ai").setup()
		-- autopairs
		require("mini.pairs").setup()
		require("mini.align").setup()
		require("mini.operators").setup()
		require("mini.icons").setup()
		require("mini.surround").setup()
	end,
}
