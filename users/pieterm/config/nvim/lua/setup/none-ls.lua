local status, none_ls = pcall(require, "none-ls")
if (not status) then return end

-- for conciseness
local formatting = none_ls.builtins.formatting -- to setup formatters
local diagnostics = none_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure none_ls
none_ls.setup({
  -- setup formatters & linters
  sources = {
    -- none_ls.builtins.code_actions.gitsigns,
    --  to disable file types use
    --  "formatting.prettier.with({disabled_filetypes: {}})" (see none-ls docs)
    formatting.prettier, -- js/ts formatter
    diagnostics.eslint_d.with({ -- js/ts linter
      -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
      end,
    }),
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
