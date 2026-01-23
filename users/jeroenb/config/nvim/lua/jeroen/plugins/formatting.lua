return {
	"stevearc/conform.nvim",
	dependencies = {
		{ "nathom/filetype.nvim", lazy = true },
	},
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
				hcl = { "tfmt" },
				tf = { "tfmt" },
				terraform = { "tfmt" },
			},
			formatters = {
				tfmt = {
					-- Specify the command and its arguments for formatting
					command = "tofu",
					args = { "fmt", "-" },
					stdin = true,
				},
			},
			-- Set up format-on-save
			format_on_save = { async = false, timeout_ms = 1500, lsp_fallback = true },
		})
		-- Setup overrides for file extensions
		require("filetype").setup({
			overrides = {
				extensions = {
					tf = "terraform",
					tfvars = "terraform",
					tfstate = "json",
				},
			},
		})
	end,
}
