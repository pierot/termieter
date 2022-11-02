local u = require('utils')

--vim.cmd("colorscheme jellybeans-nvim")
vim.cmd("colorscheme gruvbox")

u.map('n', '<silent> [oh', ':call gruvbox#hls_show()<CR>')
u.map('n', '<silent> ]oh', ':call gruvbox#hls_hide()<CR>')
u.map('n', '<silent> coh', ':call gruvbox#hls_toggle()<CR>')

function ToggleTheme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end

u.map('n', '<F5>', ':lua ToggleTheme()<CR>')           -- Switch between windows by hitting <Tab> twice

vim.api.nvim_exec([[
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
]], true)
