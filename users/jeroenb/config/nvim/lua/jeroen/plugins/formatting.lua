return {
	"stevearc/conform.nvim",
	event = { "BufNewFile", "BufReadPre", "BufWritePre" },
	-- enabled = "false",
	-- cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>tt",
			function()
				require("conform").format({ async = false, timeout_ms = 500, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				python = { "isort", "black" },
				markdown = { "prettierd" },
				json = { "prettierd" },
				elixir = { "mix" },
				heex = { "mix" },
			},
			-- Set up format-on-save
			format_on_save = { async = false, timeout_ms = 1500, lsp_fallback = true },
		})
	end,
}
