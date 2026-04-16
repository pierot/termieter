return {
	"elixir-tools/elixir-tools.nvim",
	enabled = "true",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local elixir = require("elixir")
		elixir.setup({
			-- Switching to ExpertLS
			nextls = { enable = false },
			credo = {},
			elixirls = { enable = false },
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
