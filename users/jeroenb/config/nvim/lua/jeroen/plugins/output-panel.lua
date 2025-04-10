return {
	"mhanberg/output-panel.nvim",
	enabled = "false",
	event = "VeryLazy",
	config = function()
		require("output_panel").setup({})
	end,
}
