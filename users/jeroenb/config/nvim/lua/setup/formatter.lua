local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "" },
    stdin = true,
  }
end

require("formatter").setup({
  logging = true,
  filetype = {
    javascript = { prettier },
    typescript = { prettier },
    typescriptreact = { prettier },
    html = { prettier },
    css = { prettier },
    scss = { prettier },
    markdown = { prettier }
  },
})
 
-- Runs Formatter on save

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.tsx,*.css,*.scss,*.md,*.html,*.ex,*.exs,*.eex,*.leex FormatWrite
augroup END
]], true)
