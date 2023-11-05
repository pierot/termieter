--vim.cmd("colorscheme jellybeans-nvim")
--vim.cmd("colorscheme gruvbox")
-- vim.cmd("colorscheme tokyonight-night")
--vim.cmd("colorscheme catppuccin")

function ToggleTheme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd("colorscheme catppuccin-latte")
    -- vim.cmd("colorscheme tokyonight-day")
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme tokyonight-night")
  end
end

vim.keymap.set('n', '<F5>', ':lua ToggleTheme()<CR>')           -- Switch between windows by hitting <Tab> twice
