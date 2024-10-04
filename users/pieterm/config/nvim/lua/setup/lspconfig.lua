local lspconfig_setup, lspconfig = pcall(require, "lspconfig")
if not lspconfig_setup then
	return
end

local cmp_nvim_lsp_setup, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_setup then
	return
end

local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)

	-- keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	bufopts.desc = "Show LSP definitions"
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts) -- show lsp definitions

	bufopts.desc = "Show LSP implementations"
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts) -- show lsp implementations

	bufopts.desc = "Show LSP type definitions"
	keymap.set("n", "gp", "<cmd>Telescope lsp_type_definitions<CR>", bufopts) -- show lsp type definitions

	keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

	-- keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- keymap.set('n', '<space>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	-- keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	-- keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	-- keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

lspconfig["ts_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

local protocol = require("vim.lsp.protocol")
protocol.CompletionItemKind = {
	"", -- Text
	"", -- Method
	"", -- Function
	"", -- Constructor
	"", -- Field
	"", -- Variable
	"", -- Class
	"ﰮ", -- Interface
	"", -- Module
	"", -- Property
	"", -- Unit
	"", -- Value
	"", -- Enum
	"", -- Keyword
	"﬌", -- Snippet
	"", -- Color
	"", -- File
	"", -- Reference
	"", -- Folder
	"", -- EnumMember
	"", -- Constant
	"", -- Struct
	"", -- Event
	"ﬦ", -- Operator
	"", -- TypeParameter
}

-- configure Elixir language server
local path = require("mason-core.path")
local path_to_elixirls = path.concat({ vim.fn.stdpath("data"), "mason", "bin", "elixir-ls" })

-- Setup
lspconfig["elixirls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { path_to_elixirls },
	settings = {
		elixirLS = {
			fetchDeps = false,
			dialyzerFormat = "dialyxir_long",
			dialyzerEnabled = true,
			suggestSpecs = true,
		},
	},
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
