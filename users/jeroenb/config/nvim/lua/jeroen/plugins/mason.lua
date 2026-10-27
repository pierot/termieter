-- Maintenance moved from williamboman/* to mason-org/* (the old repos are archived).
return {
	{
		-- Loaded at startup as a dependency of nvim-lspconfig: setup() puts
		-- mason/bin on PATH, which the servers in vim.lsp.enable() need before
		-- the first buffer opens.
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = "VeryLazy",
		opts = {
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
		},
	},
}
