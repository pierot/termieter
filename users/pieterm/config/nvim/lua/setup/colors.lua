-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd'
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

local u = require("utils")

-- vim.g.onedark_color_overrides = {
--   background = { gui = "#1a1a1a", cterm = "235", cterm16 = "NONE" },
--   black = { gui = "#1a1a1a", cterm = "235", cterm16 = "NONE" },
--   foreground = { gui = "#f5f7fc", cterm = "145", cterm16 = "15" },
--   white = { gui = "#f5f7fc", cterm = "145", cterm16 = "15" },
--   blue = { gui = "#32a4ec", cterm = "39", cterm16 = "4" },
--   red = { gui = "#f96874", cterm = "204", cterm16 = "1" },
--   dark_red = { gui = "#eb6559", cterm = "196", cterm16 = "9" },
--   green = { gui = "#a0e470", cterm = "114", cterm16 = "2" },
--   yellow = { gui = "#f7ec4a", cterm = "180", cterm16 = "3" },
--   purple = { gui = "#d375f0", cterm = "170", cterm16 = "5" },
--   cyan = { gui = "#38ebf2", cterm = "38", cterm16 = "6" },
--   comment_grey = { gui = "#7b8393", cterm = "59", cterm16 = "7" }
-- }

require("tokyonight").setup({
  transparent = true,
  transparent_sidebar = true,
  italic_functions = true,
  dark_float = true,
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

function ToggleTheme()
  if vim.o.background == "dark" then
    vim.cmd("colorscheme tokyonight-day")
    vim.o.background = "light"
  else
    vim.cmd("colorscheme tokyonight-night")
    vim.o.background = "dark"
  end
end

u.map('n', '<F5>', ':lua ToggleTheme()<CR>')
