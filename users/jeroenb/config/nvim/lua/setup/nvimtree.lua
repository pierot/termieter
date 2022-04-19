local u = require("utils")

require'nvim-tree'.setup({
  open_on_setup = false,
  update_to_buf_dir = { enable = true, auto_open = false },
  diagnostics = {
    enable = true
  }
})

u.map('n', '<c-n>', '<cmd>NvimTreeToggle<CR>')
u.map('n', 'R', '<cmd>NvimTreeRefresh<CR>')
