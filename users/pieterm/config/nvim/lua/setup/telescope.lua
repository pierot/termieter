local u = require("utils")

u.map("n", "<c-p>", "<cmd>Telescope find_files<CR>")
u.map("n", "<leader>b", "<cmd>Telescope buffers<CR>")
u.map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
u.map("n", "<leader>ff", "<cmd>Telescope grep_string<CR>")
--u.map('n', '<leader>fb', '<cmd>Telescope file_browser<CR>')
u.map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
u.map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
--map('n', '<leader>gs', '<cmd>Telescope git_status<CR>')

local setup, telescope = pcall(require, "telescope")
if not setup then
  return
end

local previewers_setup, previewers = pcall(require, "telescope.previewers")
if not previewers_setup then
  return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

--[[ local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = false
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end ]]

telescope.setup({
  defaults = {
    path_display = { "truncate" },
    file_ignore_patterns = { "node_modules", "vendor", "**/*.min.js", "priv/static/js", "*.svg", "flow-typed" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    -- buffer_previewer_maker = new_maker,
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      -- requires 'fd' te be installed
      find_command = {
        "fd",
        "--type",
        "f",
        "--hidden",
        "--exclude",
        ".git",
        "--exclude",
        "node_modules",
        "--exclude",
        "flow-typed",
      },
    },
    buffers = {
      theme = "ivy",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
