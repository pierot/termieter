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

-- u.opt('w', 'list', false)                               -- Hide some invisible characters (tabs...)
-- u.opt('w', 'listchars', 'tab:»·,trail:·,eol:¬,nbsp:_')
-- u.opt('g', 'ffs', 'unix,mac,dos')	                      -- Support all three, in this order
-- 
-- u.opt('o', 'hidden', true)                              -- Enable modified buffers in background
-- u.opt('o', 'scrolloff', 4 )                             -- Lines of context
-- u.opt('o', 'sidescrolloff', 8)                          -- Columns of context
-- 
-- u.opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
-- u.opt('o', 'formatoptions', 'tcqj')                     -- j: Delete comment characters when joining lines.
-- 
-- u.opt('o', 'shiftround', true)                          -- Round indent
-- u.opt('w', 'lbr', true)                                 -- Wrap long lines at a character in 'breakat' rather than last character that fits screen
-- 
-- u.opt('g', 'hidden', true)                              -- Enable switching between buffers without saving
-- u.opt('g', 'switchbuf', 'usetab')                       -- Switch to existing tab then window when switching buffer
-- u.opt('g', 'fsync', true)                               -- Sync after write
-- u.opt('g', 'confirm', true)                             -- Ask whether to save changed files
-- u.opt('g', 'lazyredraw', true)                          -- Do not redraw when executing macros
-- u.opt('g', 'showmatch', true)                           -- Briefly jumps the cursor to the matching brace on insert
-- 
-- u.opt('o', 'completeopt', 'menu,menuone,noselect')      -- Completion options, needed for cmp
-- u.opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
-- u.opt('o', 'wildignore', '*.o,*~,*node_modules*,.git,.yarn,*.min.*,*map,*ts-build') -- Ignore when tab completing
-- u.opt('o', 'wildmenu', true)
-- u.opt('o', 'wildignorecase', true)
-- 
-- -- Buffers
-- u.opt('g', 'hidden', true)                              -- Enable switching between buffers without saving
-- u.opt('g', 'switchbuf', 'usetab')                       -- Switch to existing tab then window when switching buffer
-- u.opt('g', 'fsync', true)                               -- Sync after write
-- u.opt('g', 'confirm', true)                             -- Ask whether to save changed files
-- 
-- u.opt('o', 'mouse', 'a')
-- 
-- cmd 'syntax enable'
-- cmd 'filetype plugin indent on'
-- 
-- -- highlights
-- vim.opt.winblend = 0
-- vim.opt.wildoptions = 'pum'
-- vim.opt.pumblend = 5
