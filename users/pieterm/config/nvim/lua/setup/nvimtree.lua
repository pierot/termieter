local setup, nvimtree = pcall(require, "nvim-tree")
if (not setup) then return end

local u = require("utils")

nvimtree.setup({
  hijack_directories = { enable = true, auto_open = true },
  diagnostics = {
    enable = true
  },
  view = {
    width = 40
  }
})

--[[ local function open_nvim_tree()
  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree }) ]]

u.map('n', '<c-n>', '<cmd>NvimTreeToggle<CR>')
u.map('n', 'R', '<cmd>NvimTreeRefresh<CR>')
