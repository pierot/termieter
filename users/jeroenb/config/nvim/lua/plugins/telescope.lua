local setup, telescope = pcall(require, "telescope")
if (not setup) then return end

local previewers_setup, previewers = pcall(require, "telescope.previewers")
if (not previewers_setup) then return end

local actions_setup, actions = pcall(require, "telescope.actions")
if (not actions_setup) then return end

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = false
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

telescope.setup {
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
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
      }
    }
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
