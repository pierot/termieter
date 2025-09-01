local status, mason = pcall(require, "mason")
if not status then
	return
end

mason.setup({})

local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end

lspconfig.setup({
	ensure_installed = {
		"ansiblels",
		"bashls",
		"cssls",
		"dockerls",
		"expert",
		"emmet_ls",
		"html",
		-- "isort",
		"lua_ls",
		"luau_lsp",
		-- "markdownlint",
		-- "prettierd",
		-- "sql-formatter",
		-- "sqlfmt",
		"tailwindcss",
		"yamlls",
		-- "yamlfmt",
		-- "yamllint"
	},
})
