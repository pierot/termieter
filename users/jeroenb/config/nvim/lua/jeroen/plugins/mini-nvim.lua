return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		-- autopairs
		require("mini.pairs").setup()
	end,
}
