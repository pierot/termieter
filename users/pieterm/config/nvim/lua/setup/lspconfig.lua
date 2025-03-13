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
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- Navigation
	-- keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)

	bufopts.desc = "Show LSP definitions"
	keymap.set("n", "gnd", "<cmd>Telescope lsp_definitions<CR>", bufopts)

	bufopts.desc = "Show LSP implementations"
	keymap.set("n", "gni", "<cmd>Telescope lsp_implementations<CR>", bufopts)

	bufopts.desc = "Show LSP type definitions"
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", bufopts)

	bufopts.desc = "Show LSP references"
	keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)

	-- Documentation & Help
	keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	-- keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

	-- Code actions
	bufopts.desc = "Show code actions"
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

	bufopts.desc = "Rename symbol"
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

	keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	-- Diagnostics navigation
	bufopts.desc = "Go to next diagnostic"
	keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)

	bufopts.desc = "Go to previous diagnostic"
	keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)

	bufopts.desc = "Show diagnostics in floating window"
	keymap.set("n", "<leader>d", vim.diagnostic.open_float, bufopts)

	bufopts.desc = "Show diagnostics in quickfix list"
	keymap.set("n", "<leader>q", vim.diagnostic.setqflist, bufopts)

	-- Elixir specific keybindings (if client.name == "elixirls")
	if client.name == "elixirls" then
		bufopts.desc = "Run Elixir test under cursor"
		keymap.set("n", "<leader>tt", ":ElixirTestWatch<CR>", bufopts)

		bufopts.desc = "Run Elixir test file"
		keymap.set("n", "<leader>tf", ":ElixirTestFile<CR>", bufopts)

		bufopts.desc = "Open IEx terminal"
		keymap.set("n", "<leader>ix", ":ElixirIEx<CR>", bufopts)

		bufopts.desc = "Compile Elixir project"
		keymap.set("n", "<leader>mc", ":!mix compile<CR>", bufopts)
	end
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
			fetchDeps = true,
			dialyzerFormat = "dialyxir_long",
			dialyzerEnabled = true,
			suggestSpecs = true,
			-- Additional ElixirLS settings
			enableTestLenses = true, -- Add test lenses for running tests
			mixEnv = "test", -- Set default mix environment
			trace = { server = "verbose" }, -- Help with debugging ElixirLS
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

-- You might need these Elixir helper functions
-- Create the commands if you don't have a plugin for them
vim.api.nvim_create_user_command("ElixirTestWatch", function()
	vim.cmd("vsplit term://mix test " .. vim.fn.expand("%") .. ":" .. vim.fn.line("."))
end, {})

vim.api.nvim_create_user_command("ElixirTestFile", function()
	vim.cmd("vsplit term://mix test " .. vim.fn.expand("%"))
end, {})

vim.api.nvim_create_user_command("ElixirIEx", function()
	vim.cmd("vsplit term://iex -S mix")
end, {})
