local status, mason = pcall(require, "mason")
if (not status) then return end

mason.setup({})

local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

lspconfig.setup({
  ensure_installed = { 
    "tailwindcss-language-server", 
    "css-lsp",
    "emmet-ls",
    "html-lsp",
    "elixir-ls",
    "prettierd"
  }
})
