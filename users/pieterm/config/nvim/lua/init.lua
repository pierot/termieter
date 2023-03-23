-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd'
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

local u = require('utils')

-------------------------------------------------
-- GENERAL SETTINGS
-------------------------------------------------

-- Basic settings
local indent = 2

u.opt('o', 'splitbelow', true)                          -- Put new windows below current
u.opt('o', 'splitright', true)                          -- Put new windows right of current
u.opt('o', 'termguicolors', true)                       -- True color support
u.opt('w', 'list', false)                               -- Hide some invisible characters (tabs...)
u.opt('w', 'listchars', 'tab:»·,trail:·,eol:¬,nbsp:_')
u.opt('g', 'ffs', 'unix,mac,dos')	                      -- Support all three, in this order

u.opt('w', 'number', true)                              -- Print line number
u.opt('o', 'hidden', true)                              -- Enable modified buffers in background
u.opt('o', 'scrolloff', 4 )                             -- Lines of context
u.opt('o', 'sidescrolloff', 8)                          -- Columns of context

u.opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
u.opt('o', 'formatoptions', 'tcqj')                     -- j: Delete comment characters when joining lines.

u.opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
u.opt('b', 'shiftwidth', indent)                        -- Size of an indent
u.opt('o', 'shiftround', true)                          -- Round indent
u.opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
u.opt('w', 'wrap', true)
u.opt('w', 'lbr', true)                                 -- Wrap long lines at a character in 'breakat' rather than last character that fits screen

u.opt('b', 'smartindent', true)                         -- Insert indents automatically
u.opt('b', 'autoindent', true)
u.opt('b', 'copyindent', true)                          -- Take indentation from previous line

u.opt('o', 'hlsearch', true)                            -- Highlight search things
u.opt('o', 'incsearch', true)                           -- Make search act like search in modern browsers
u.opt('o', 'ignorecase', true)                          -- Ignore case
u.opt('o', 'smartcase', true)                           -- Don't ignore case with capitals

u.opt('g', 'lazyredraw', true)                          -- Do not redraw when executing macros
u.opt('w', 'cursorline', true)                          -- Highlight current line
u.opt('g', 'showmatch', true)                           -- Briefly jumps the cursor to the matching brace on insert

u.opt('o', 'completeopt', 'menu,menuone,noselect')      -- Completion options, needed for cmp
u.opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
u.opt('o', 'wildignore', '*.o,*~,*node_modules*,.git,.yarn,*.min.*,*map,*ts-build') -- Ignore when tab completing
u.opt('o', 'wildmenu', true)
u.opt('o', 'wildignorecase', true)

u.opt('o', 'clipboard', 'unnamed,unnamedplus')

-- Buffers
u.opt('g', 'hidden', true)                              -- Enable switching between buffers without saving
u.opt('g', 'switchbuf', 'usetab')                       -- Switch to existing tab then window when switching buffer
u.opt('g', 'fsync', true)                               -- Sync after write
u.opt('g', 'confirm', true)                             -- Ask whether to save changed files

u.opt('o', 'mouse', 'a')

cmd 'syntax enable'
cmd 'filetype plugin indent on'

-------------------------------------------------
-- MAPPINGS
-------------------------------------------------

g.mapleader = ','

u.map('n', 'Q', '<Nop>')                                -- We don't do ex mode
u.map('', ';', ':')                                     -- Map ; to :
u.map('n', '<leader>l', ':set list!<CR>')               -- Toggle invisible characters
u.map('n', '<CR>', '<cmd>nohlsearch<CR>')               -- Clear the search buffer when hitting return
u.map('n', 'S', 'mzi<CR><ESC>`z')                       -- Split line and preserve cursor position
u.map('n', 'gI', '`.')                                  -- Move to the position where the last change was made

u.map('c', 'w!!', '<cmd>w !sudo tee % >/dev/null<CR>')  -- Write read-only file via sudo
u.map('n', '<leader>w', '<cmd>w<CR>')                   -- Alias to :w

-- Path copy helpers
u.map('n', '<leader>cf', '<cmd>let @+=expand("%")<CR>')     -- relative path  (src/foo.txt)
u.map('n', '<leader>cF', '<cmd>let @+=expand("%:p")<CR>')   -- absolute path  (/something/src/foo.txt)
u.map('n', '<leader>ct', '<cmd>let @+=expand("%:t")<CR>')   -- filename       (foo.txt)
u.map('n', '<leader>cd', '<cmd>let @+=expand("%:p:h")<CR>') -- directory name (/something/src)

-- Reselect last selection after indent/un-indent in visual/select modes
u.map('v', '<', '<gv')
u.map('v', '>', '>gv')
u.map('v', '<Tab>', '>')
u.map('v', '<S-Tab>', '<')

-- Mappings / Split windows
u.map('n', '<c-j>', '<c-w>j')
u.map('n', '<c-k>', '<c-w>k')
u.map('n', '<c-h>', '<c-w>h')
u.map('n', '<c-l>', '<c-w>l')

u.map('n', '<leader><Tab>', '<c-^>')                    -- Switch between last two files

u.map('','+', '3<c-w>>')                                -- Enlarge splits
u.map('', '-', '3<c-w><')

-- Mappings / HTML
u.map('v', '<leader><leader>b', '<S-S><strong>')
u.map('v', '<leader><leader>i', '<S-S><em>')

u.map('n', 'S', 'mzi<CR><ESC>`z')                       -- Split line and preserve cursor position

cmd 'autocmd BufWritePost *.exs,*.ex silent :!source .env && mix format --check-equivalent %'

u.map('t', '<Esc>', '<C-\\><C-n>')

-- highlights
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5
vim.opt.background = 'dark'

-- all small plugins that need nothing more than a simple
-- setup are setup here
vim.g.ackprg = 'rg --vimgrep --pcre2'         -- ack
-- u.map('n', '<leader>gs', '<cmd>Git<CR>')      -- fugitive
