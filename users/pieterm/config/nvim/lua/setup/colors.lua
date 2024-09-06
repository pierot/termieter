-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd'
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

local u = require("utils")

require("tokyonight").setup({
  light_style = "day",
  terminal_colors = true,
  transparent = true,
  transparent_sidebar = true,
  italic_functions = true,
  dark_float = true,
  lualine_bold = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
  day_brightness = 0.3,
  on_highlights = function(hl, c)
    hl.Normal = {
      bg = "#1a1a1a",
      fg = "#fafafa"
    }
  end,
})

vim.o.termguicolors = true
vim.cmd("colorscheme tokyonight-night")
vim.o.background = "dark"

function ToggleTheme()
  if vim.o.background == "dark" then
    -- vim.cmd("colorscheme tokyonight-day")
    vim.o.background = "light"
  else
    -- vim.cmd("colorscheme tokyonight-night")
    vim.o.background = "dark"
  end
end

u.map('n', '<F5>', ':lua ToggleTheme()<CR>')
