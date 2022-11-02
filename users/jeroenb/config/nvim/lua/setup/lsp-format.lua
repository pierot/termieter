--[[ local prettier = function()
  return {
    exe = "prettier",
    args = {
      '--config-precedence',
      'prefer-file',
      -- you can add more global setup here 
      '--stdin-filepath',
      vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
    },
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
}) ]]
 
-- -- Runs Formatter on save
-- 
-- vim.api.nvim_exec([[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost *.js,*.ts,*.tsx,*.css,*.scss,*.md,*.html,*.ex,*.exs,*.eex,*.leex,*.heex FormatWrite
-- augroup END
-- ]], true)
-- 
-- -- Some Elixir specific things
-- 
-- vim.cmd "au BufRead,BufNewFile *.heex set filetype=eelixir"
-- vim.cmd "au FileType elixir let $MIX_ENV = 'test'"
--
--
