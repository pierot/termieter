local u = require("utils")

u.map('n', '<c-p>', '<cmd>Telescope find_files<CR>')
u.map('n', '<leader>b', '<cmd>Telescope buffers<CR>')
u.map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
u.map('n', '<leader>fb', '<cmd>Telescope file_browser<CR>')
u.map('n', '<leader>gb', '<cmd>Telescope git_branches<CR>')
u.map('n', '<leader>gc', '<cmd>Telescope git_commits<CR>')
u.map('n', '<leader>gss', '<cmd>Telescope git_status<CR>')

local previewers = require('telescope.previewers')

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = false
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require('telescope').setup {
  defaults = {
    buffer_previewer_maker = new_maker,
    file_ignore_patterns = {"node_modules/.*", "vendor/.*"},
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    buffer_previewer_maker = new_maker,
  },
  pickers = {
    find_files = {
      theme = "ivy",
      -- requires 'fd' te be installed
      find_command = {'fd', '--type', 'f', '--hidden', '--exclude', '.git' }
    },
    buffers = {
      theme = "ivy"
    }
  }
}
