local status, mason = pcall(require, "mason")
if (not status) then return end

mason.setup({})

local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

lspconfig.setup({
  ensure_installed = { 
    "tailwindcss", 
    "cssls",
    "emmet_ls",
    "html",
    "elixirls"
  } -- //, "prettier_d" },
})
