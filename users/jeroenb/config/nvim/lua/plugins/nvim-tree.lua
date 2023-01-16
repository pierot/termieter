local setup, nvimtree = pcall(require, "nvim-tree")
if (not setup) then return end

nvimtree.setup({
  open_on_setup = false,
  hijack_directories = { enable = true, auto_open = false },
  diagnostics = {
    enable = true
  }
})

-- u.map('n', '<c-n>', '<cmd>NvimTreeToggle<CR>')
-- u.map('n', 'R', '<cmd>NvimTreeRefresh<CR>')

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
