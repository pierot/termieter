local u = require("utils")

vim.cmd("colorscheme onedark")

function ToggleTheme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end

u.map('n', '<F5>', ':lua ToggleTheme()<CR>')           -- Switch between windows by hitting <Tab> twice
