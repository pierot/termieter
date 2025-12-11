-- Import cmp-nvim-lsp plugin for completion capabilities
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  return
end

-- Enable autocompletion capabilities for LSP
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Configure default LSP settings with capabilities
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Small manual overrides for specific LSP servers
-- emmet_ls: Only for HEEx templates (Phoenix)
vim.lsp.config.emmet_ls = {
	filetypes = { "heex" },
}

-- TailwindCSS support for HEEx (Phoenix templates)
vim.lsp.config.tailwindcss = {
	filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "heex" },
}

-- LSP keymaps (set when LSP attaches to buffer)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "Go to declaration" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "Show references" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf, desc = "Go to implementation" })
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = args.buf, desc = "Go to type definition" })

    -- Telescope alternatives for navigation (commented out - uncomment if you prefer Telescope)
    -- vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = args.buf, desc = "Go to definition" })
    -- vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { buffer = args.buf, desc = "Show references" })
    -- vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { buffer = args.buf, desc = "Go to implementation" })
    -- vim.keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", { buffer = args.buf, desc = "Go to type definition" })

    -- Documentation & Help
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover documentation" })
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = args.buf, desc = "Signature help" })

    -- Code actions
    vim.keymap.set(
      { "n", "v" },
      "<leader>ca",
      vim.lsp.buf.code_action,
      { buffer = args.buf, desc = "Code action" }
    )
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename symbol" })

    -- Formatting
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = args.buf, desc = "Format buffer" })

    -- Diagnostics navigation
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = args.buf, desc = "Previous diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = args.buf, desc = "Next diagnostic" })
    vim.keymap.set(
      "n",
      "<leader>d",
      vim.diagnostic.open_float,
      { buffer = args.buf, desc = "Line diagnostics" }
    )
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, { buffer = args.buf, desc = "Quickfix list" })
  end,

  -- Enable LSP servers after setting up the autocmd
  vim.lsp.enable({ "html", "ts_ls", "cssls", "tailwindcss", "emmet_ls", "lua_ls", "expert" }),
})

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  update_in_insert = false, -- Improved performance: diagnostics only update when leaving insert mode
  float = {
    source = "always",     -- Or "if_many"
  },
  signs = {
    -- Diagnostic symbols in the sign column (gutter)
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})
