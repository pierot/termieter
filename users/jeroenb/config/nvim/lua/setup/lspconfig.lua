local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

-- Update for cmp
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Elixir
local path = require "mason-core.path"
local path_to_elixirls = path.concat({vim.fn.stdpath "data", "mason", "bin", "elixir-ls"}) 

-- Setup
nvim_lsp.elixirls.setup({
  on_attach = on_attach, 
  capabilities = capabilities,
  cmd = { path_to_elixirls },
  settings = {
    elixirLS = {
      fetchDeps = false,
      dialyzerFormat = "dialyxir_long",
      dialyzerEnabled = true,
      suggestSpecs = true
    }
  }
})

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities
}

nvim_lsp.tailwindcss.setup {}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
}
)

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})


-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
-- 
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
-- 
--   -- Mappings.
--   local opts = { noremap=true, silent=true }
-- 
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   buf_set_keymap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
--   buf_set_keymap("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
--   buf_set_keymap('n', '<leader>ce', '<cmd>lua vim.diagnostic.get()<CR>', opts)
--   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--   buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- 
--   -- Set some keybinds conditional on server capabilities
--   if client.server_capabilities.document_formatting then
--       buf_set_keymap("n", "<leader>f",
--                       "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--   elseif client.server_capabilities.document_range_formatting then
--       buf_set_keymap("n", "<leader>f",
--                       "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
--   end
-- 
--   -- Set autocommands conditional on server_capabilities
--   if client.server_capabilities.document_highlight then
--       vim.api.nvim_exec([[
--       hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--       hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--       hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--       augroup lsp_document_highlight
--       augroup END
--       ]], false)
--   end
-- 
--       --[[ autocmd! * <buffer>
--       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references() ]]
-- end
-- 
-- -- Capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- 
-- 
-- -- Resolvers
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }
-- 
-- -- Code actions
-- capabilities.textDocument.codeAction = {
--   dynamicRegistration = true,
--   codeActionLiteralSupport = {
--       codeActionKind = {
--           valueSet = (function()
--               local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
--               table.sort(res)
--               return res
--           end)()
--       }
--   }
-- }
-- 
-- -- Snippets
-- capabilities.textDocument.completion.completionItem.snippetSupport = true;
-- 
-- -- Elixir
-- local os = os.getenv("OS")
-- local path_to_elixirls = ""
-- if(os == "OSX") 
-- then
-- path_to_elixirls = vim.fn.expand("/Users/jeroenb/.local/share/elixir-ls/release/language_server.sh")
-- else
-- path_to_elixirls = vim.fn.expand("/home/jeroen/.local/share/elixir-ls/release/language_server.sh")
-- end
-- 
-- -- Setup
-- nvim_lsp.elixirls.setup({
--   on_attach = on_attach, 
--   capabilities = capabilities,
--   cmd = { path_to_elixirls },
--   settings = {
--     elixirLS = {
--       fetchDeps = false,
--       dialyzerFormat = "dialyxir_long",
--       dialyzerEnabled = true,
--       suggestSpecs = true
--     }
--   }
-- })
-- 
-- nvim_lsp.tsserver.setup({ 
--   on_attach = on_attach, 
--   capabilities = capabilities
-- })
-- --
-- -- You will likely want to reduce updatetime which affects CursorHold
-- -- note: this setting is global and should be set only once
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
--  
-- -- LSP Prevents inline buffer annotations
-- vim.diagnostic.get()
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   virtual_text = true,
--   signs = true,
--   underline = true,
--   update_on_insert = false,
-- })
-- 
-- local signs = {
--   Error = "ﰸ",
--   Warn = "",
--   Hint = "",
--   Info = "",
-- }
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
-- end
-- 
-- -- Formatting
-- 
-- -- autocmd BufWritePre *.js,*.ts,*.tsx,*.css,*.scss,*.md,*.html,*.ex,*.exs,*.eex,*.leex,*.heex lua vim.lsp.buf.format({ async = false })
-- vim.api.nvim_exec([[
--   autocmd BufWritePost *.exs,*.ex silent :!source .env && mix format --check-equivalent %
-- ]], true)
-- 
