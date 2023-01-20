local setup, nvimtree = pcall(require, "nvim-tree")
if (not setup) then return end

local u = require("utils")

nvimtree.setup({
  open_on_setup = true,
  hijack_directories = { enable = true, auto_open = true },
  diagnostics = {
    enable = true
  }
})

u.map('n', '<c-n>', '<cmd>NvimTreeToggle<CR>')
u.map('n', 'R', '<cmd>NvimTreeRefresh<CR>')
