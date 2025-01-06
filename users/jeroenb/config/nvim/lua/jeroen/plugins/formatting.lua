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
	-- Everything in opts will be passed to setup()
	-- opts = {
	-- 	-- Define your formatters
	-- 	formatters_by_ft = {
	-- 		lua = { "stylua" },
	-- 		javascript = { "prettier" },
	-- 		typescript = { "prettier" },
	-- 		javascriptreact = { "prettier" },
	-- 		typescriptreact = { "prettier" },
	-- 		html = { "prettier" },
	-- 		css = { "prettier" },
	-- 		markdown = { "prettier" },
	-- 		json = { "prettier" },
	-- 	},
	-- 	-- Set up format-on-save
	-- 	format_on_save = { async = false, timeout_ms = 500, lsp_fallback = true },
	-- 	-- Customize formatters
	-- 	formatters = {
	-- 		shfmt = {
	-- 			prepend_args = { "-i", "2" },
	-- 		},
	-- 	},
	-- },
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
				markdown = { "prettierd" },
				json = { "prettierd" },
			},
			-- Set up format-on-save
			format_on_save = { async = false, timeout_ms = 500, lsp_fallback = true },
		})
	end,
	-- init = function()
	-- 	-- If you want the formatexpr, here is the place to set it
	-- 	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	-- end,
}
