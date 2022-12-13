--vim.cmd("colorscheme jellybeans-nvim")
--vim.cmd("colorscheme gruvbox")
vim.cmd("colorscheme tokyonight-night")

function ToggleTheme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end

vim.keymap.set('n', '<F5>', ':lua ToggleTheme()<CR>')           -- Switch between windows by hitting <Tab> twice
