-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo, g = vim.g}

-------------------------------------------------
-- UTILS
-------------------------------------------------

-- https://github.com/neovim/neovim/pull/13479
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------------------------------------
-- PLUGINS
-------------------------------------------------

cmd 'packadd paq-nvim'                                -- load the package manager
local paq = require('paq-nvim').paq                   -- a convenient alias

paq {'savq/paq-nvim', opt = true}                     -- paq-nvim manages itself

paq {'kyazdani42/nvim-tree.lua'}                      -- sidebar file explorer
paq {'kyazdani42/nvim-web-devicons'}                  -- web dev icons used by many plugins

paq {'nvim-lua/popup.nvim'}                           -- ui plugin used by many
paq {'nvim-lua/plenary.nvim'}                         -- ui plugin used by many

paq {'hoob3rt/lualine.nvim'}                          -- statusline
paq {'akinsho/nvim-bufferline.lua'}                   -- buffer line

paq {'blackCauldron7/surround.nvim'}
paq {'tpope/vim-repeat'}
paq {'docunext/closetag.vim'}
paq {'mattn/emmet-vim'}

paq {'nvim-treesitter/nvim-treesitter'}               -- treesitter, code highlighting

-- paq {'neovim/nvim-lspconfig'}
-- paq {'hrsh7th/nvim-compe'}                            -- autocomplete

-- Telescope
paq {'nvim-telescope/telescope.nvim'}
paq {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

paq {'mileszs/ack.vim'}

paq {'kosayoda/nvim-lightbulb'}                       -- shows lightbulb in sign column when textDocument/codeAction available at current cursor

paq {'steelsojka/pears.nvim'}                         -- Auto Pairs

paq {'terrortylor/nvim-comment'}                      -- Comment
paq {'JoosepAlviste/nvim-ts-context-commentstring'}   -- Comment

paq {'bfredl/nvim-miniyank'}                          -- Proper yank and pasting

-- paq {
--   'lewis6991/gitsigns.nvim',
--   requires = {'nvim-lua/plenary.nvim'},
--   config = function()
--     require('gitsigns').setup()
--   end
-- }

paq{'dracula/vim', as='dracula'}                      -- Use `as` to alias a package name (here `vim`)

-------------------------------------------------
-- GENERAL SETTINGS
-------------------------------------------------

-- Basic settings
local indent = 2

cmd 'colorscheme dracula'                             -- Put your favorite colorscheme here

opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
-- opt('w', 'list', true)                                -- Show some invisible characters (tabs...)
opt('w', 'listchars', 'tab:»·,trail:·,eol:¬,nbsp:_')
opt('g', 'ffs', 'unix,mac,dos')	                      -- Support all three, in this order

opt('w', 'number', true)                              -- Print line number
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'scrolloff', 4 )                             -- Lines of context
opt('o', 'sidescrolloff', 8)                          -- Columns of context

opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'formatoptions', 'tcqj')                     -- j: Delete comment characters when joining lines.

opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('o', 'shiftround', true)                          -- Round indent
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('w', 'wrap', false)
opt('w', 'lbr', true)                                 -- Wrap long lines at a character in 'breakat' rather than last character that fits screen

opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'autoindent', true)
opt('b', 'copyindent', true)                          -- Take indentation from previous line

opt('o', 'hlsearch', true)                            -- Highlight search things
opt('o', 'incsearch', true)                           -- Make search act like search in modern browsers
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals

opt('g', 'hidden', true)                              -- Enable switching between buffers without saving
opt('g', 'switchbuf', 'usetab')                       -- Switch to existing tab then window when switching buffer
opt('g', 'fsync', true)                               -- Sync after write
opt('g', 'confirm', true)                             -- Ask whether to save changed files
opt('g', 'lazyredraw', true)                          -- Do not redraw when executing macros
opt('w', 'cursorline', true)                          -- Highlight current line
opt('g', 'showmatch', true)                           -- Briefly jumps the cursor to the matching brace on insert

opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options
opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('o', 'wildignore', '*.o,*~,*node_modules*,.git,.yarn,*.min.*,*map') -- Ignore when tab completing
opt('o', 'wildmenu', true)
opt('o', 'wildignorecase', true)

opt('o', 'clipboard', 'unnamed,unnamedplus')

-- Buffers
opt('g', 'hidden', true)                              -- Enable switching between buffers without saving
opt('g', 'switchbuf', 'usetab')                       -- Switch to existing tab then window when switching buffer
opt('g', 'fsync', true)                               -- Sync after write
opt('g', 'confirm', true)                             -- Ask whether to save changed files

opt('o', 'mouse', 'a')

cmd 'syntax enable'
cmd 'filetype plugin indent on'

-------------------------------------------------
-- MAPPINGS
-------------------------------------------------

g.mapleader = ','

map('n', 'Q', '<Nop>')                                -- We don't do ex mode
map('', ';', ':')                                     -- Map ; to :
map('n', '<leader>l', ':set list!<CR>')               -- Toggle invisible characters
map('n', '<CR>', '<cmd>nohlsearch<CR>')               -- Clear the search buffer when hitting return
map('n', 'S', 'mzi<CR><ESC>`z')                       -- Split line and preserve cursor position
map('n', 'gI', '`.')                                  -- Move to the position where the last change was made

map('c', 'w!!', '<cmd>w !sudo tee % >/dev/null<CR>')  -- Write read-only file via sudo
map('n', '<leader>w', '<cmd>w<CR>')                   -- Alias to :w

-- Path copy helpers
map('n', '<leader>cf', '<cmd>let @*=expand("%")<CR>')     -- relative path  (src/foo.txt)
map('n', '<leader>cF', '<cmd>let @*=expand("%:p")<CR>')   -- absolute path  (/something/src/foo.txt)
map('n', '<leader>ct', '<cmd>let @*=expand("%:t")<CR>')   -- filename       (foo.txt)
map('n', '<leader>ch', '<cmd>let @*=expand("%:p:h")<CR>') -- directory name (/something/src)

-- Reselect last selection after indent/un-indent in visual/select modes
map('v', '<', '<gv')
map('v', '>', '>gv')
map('v', '<Tab>', '>')
map('v', '<S-Tab>', '<')

-- Mappings / Split windows
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-l>', '<c-w>l')

map('n', '<silent> <Tab><Tab>', '<C-w>w')             -- Switch between windows by hitting <Tab> twice
map('n', '<leader><Tab>', '<c-^>')                    -- Switch between last two files

map('','+', '3<c-w>>')                                -- Enlarge splits
map('', '-', '3<c-w><')

-- Mappings / HTML
map('v', '<leader><leader>b', '<S-S><strong>')
map('v', '<leader><leader>i', '<S-S><em>')

map('n', 'S', 'mzi<CR><ESC>`z')                       -- Split line and preserve cursor position

-- map('', '<leader>c', '"+y')       -- Copy to clipboard in normal, visual, select and operator modes

cmd 'au BufNewFile,BufRead *.ex,*.exs,*.eex set filetype=elixir'
cmd 'autocmd BufWritePost *.exs,*.ex silent :!source .env && mix format --check-equivalent %'

-------------------------------------------------
-- PLUGINS SETUP
-------------------------------------------------

-- webdev icons
require('nvim-web-devicons').setup()

-- ack
g.ackprg = 'rg --vimgrep'
-- cnoreabbrev Ack Ack!
-- cnoreabbrev ack Ack!

-- nvim-tree
g.nvim_tree_auto_open = 1
g.nvim_tree_auto_close = 1
g.nvim_tree_width_allow_resize = 1
g.nvim_tree_hide_dotfiles = 1

map('n', '<c-n>', '<cmd>NvimTreeToggle<CR>')
map('n', 'R', '<cmd>NvimTreeRefresh<CR>')

-- local tree_cb = require('nvim-tree.config').nvim_tree_callback
-- g.nvim_tree_bindings = {
--   ["I"] = tree_cb("toggle_dotfiles"),
-- }

-- yank
-- map('n', 'p', '<Plug>(miniyank-autoput)')
-- map('n', 'P', '<Plug>(miniyank-autoPut)')
-- map('n', '<leader>n', '<Plug>(miniyank-cycle)')

-- lualine
require('lualine').setup()

-- Bufferline
-- require('bufferline').setup {
--   options = {
--     offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}},
--     diagnostics = "nvim_lsp",
--   }
-- }

-- Telescope
-- Check to extend: https://github.com/varbhat/dotfiles/blob/main/dot_config/nvim/lua/utils/telescope.lua
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<c-p>', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {"node_modules/.*", "vendor/.*"},
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- Comment
require('nvim_comment').setup()

-- Auto pairs
require('pears').setup()

-- Emmet
g.use_emmet_complete_tag = 1
g.user_emmet_leader_key = '<c-e>'
g.user_emmet_settings = "{ 'javascript.jsx' : { 'extends' : 'jsx' } }" -- TODO

-- Treesitter
-- yarn global add typescript tree-sitter-cli
local ts = require('nvim-treesitter.configs')
ts.setup({
  ensure_installed = {
    "javascript", "typescript", "tsx", "jsdoc", "jsonc",
    "html", "css", "scss",
    "json", "toml", "yaml",
    "lua", "query", "elixir", "dockerfile", "php",
  },
  highlight = {
    enable = {
      enabled = true,
      use_languagetree = true
    }
  },
  indent = {
    enable = true
  },
  textobjects = {
    enable = true
  },
  -- rainbow = {
  --   enable = true,
  --   extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
  --   max_file_lines = 1000 -- Do not enable for files with more than 1000 lines, int
  -- },
  -- refactor = {
  --   highlight_definitions = {enable = true},
  --   -- highlight_current_scope = {enable = true},
  --   smart_rename = {
  --     enable = true,
  --     keymaps = {smart_rename = "grr"},
  --     navigation = {
  --       enable = true,
  --       keymaps = {
  --         goto_definition = "gnd",
  --         list_definitions = "gnD",
  --         list_definitions_toc = "gO",
  --         goto_next_usage = "<a-*>",
  --         goto_previous_usage = "<a-#>"
  --       }
  --     }
  --   }
  -- },
  -- autotag = {enable = true}
  context_commentstring = {
    enable = true,
    config = {
      elixir = '# %s'
    }
  }
})

-- LSP
require('lspconfig').elixirls.setup({
  cmd = { "/usr/local/share/elixir-ls/language_server.sh" },
})

require('lspconfig').tsserver.setup({})

-- local lspfuzzy = require 'lspfuzzy'
--
-- lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list
--
-- map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
-- map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
-- map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
-- map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
