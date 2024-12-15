return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
	event = "VeryLazy",
  config = function()
    local mason = require("mason")
    local lspconfig = require("mason-lspconfig")

    mason.setup()

    lspconfig.setup {
      ensure_installed = {
        "tailwindcss",
        -- "elixirls" ,
        "emmet_ls",
        "html"
      } -- //, "prettier_d" },
    }
  end
}
