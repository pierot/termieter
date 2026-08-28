-- Maintenance moved from williamboman/* to mason-org/* (the old repos are archived).
return {
	"mason-org/mason.nvim",
	dependencies = { "mason-org/mason-lspconfig.nvim" },
	event = "VeryLazy",
	config = function()
		local mason = require("mason")
		local lspconfig = require("mason-lspconfig")

		mason.setup()

		lspconfig.setup({
			ensure_installed = {
				"cssls",
				"emmet_ls",
				"html",
				"lua_ls",
				"tailwindcss",
				"ts_ls",
			},
			-- Servers are started from the explicit vim.lsp.enable() list in
			-- nvim-lspconfig.lua. Without this, mason-lspconfig also enables
			-- everything it finds installed, so that list stops being the
			-- single source of truth.
			automatic_enable = false,
		})
	end,
}
