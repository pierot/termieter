-- ==========================================================================
--  OPTIONS (Converted to native vim.opt for speed)
-- ==========================================================================
local opt = vim.opt
local indent = 2

-- ==========================================================================
--  PERFORMANCE & GLOBALS
-- ==========================================================================
-- Set leader BEFORE anything else to ensure plugins pick it up correctly
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Disable providers we don't use (Measurable startup improvement)
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

-- Disable built-in plugins we don't use
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- General
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.list = false -- Hide some invisible characters
opt.listchars = { tab = "»·", trail = "·", eol = "¬", nbsp = "_" }
opt.fileformats = { "unix", "mac", "dos" }

-- UI & Numbers
opt.number = true -- Print line number
opt.cursorline = true -- Highlight current line
opt.termguicolors = true -- True color support
opt.winblend = 0 -- Window transparency
opt.pumblend = 5 -- Popup menu transparency
opt.background = "dark"
opt.showtabline = 2 -- Always show tabs
opt.mouse = "a" -- Enable mouse support

-- Formatting & Indentation
opt.hidden = true -- Enable modified buffers in background
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.joinspaces = false -- No double spaces with join after a dot
opt.formatoptions = "tcqjro" -- Auto-formatting options
opt.tabstop = indent -- Number of spaces tabs count for
opt.shiftwidth = indent -- Size of an indent
opt.shiftround = true -- Round indent
opt.expandtab = true -- Use spaces instead of tabs
opt.wrap = true -- Wrap lines
opt.linebreak = true -- Wrap at words (lbr)
opt.smartindent = true -- Insert indents automatically
opt.autoindent = true
opt.copyindent = true -- Take indentation from previous line

-- Search
opt.hlsearch = true -- Highlight search things
opt.incsearch = true -- Incremental search
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.showmatch = true -- Briefly jumps cursor to matching brace

-- Completion & Wildmenu
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmode = { "list:longest" }
opt.wildmenu = true
opt.wildignorecase = true
opt.wildignore:append({ "*.o", "*~", "*node_modules*", ".git", ".yarn", "*.min.*", "*map", "*ts-build" })

-- System
opt.clipboard = "unnamed,unnamedplus" -- Sync with OS clipboard
opt.switchbuf = "usetab" -- Switch to existing tab then window
opt.fsync = true -- Sync after write
opt.confirm = true -- Ask whether to save changed files

-- Syntax (vim.opt.syntax doesn't exist, this is a command)
vim.cmd("syntax enable")

-- ==========================================================================
--  MAPPINGS (Converted to vim.keymap.set for speed)
-- ==========================================================================
-- Syntax: vim.keymap.set(mode, lhs, rhs, options)

-- General
vim.keymap.set("n", "Q", "<Nop>") -- Disable Ex mode
vim.keymap.set("", ";", ":") -- Map ; to :
vim.keymap.set("n", "<leader>l", ":set list!<CR>") -- Toggle invisible chars
vim.keymap.set("n", "<CR>", "<cmd>nohlsearch<CR>", { silent = true }) -- Clear search
vim.keymap.set("n", "gI", "`.") -- Move to last change

-- File saving
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null") -- Sudo write
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>") -- Fast save

-- Copy Path Helpers
vim.keymap.set("n", "<leader>cf", '<cmd>let @+=expand("%")<CR>') -- Relative path
vim.keymap.set("n", "<leader>cF", '<cmd>let @+=expand("%:p")<CR>') -- Absolute path
vim.keymap.set("n", "<leader>ct", '<cmd>let @+=expand("%:t")<CR>') -- Filename
vim.keymap.set("n", "<leader>cd", '<cmd>let @+=expand("%:p:h")<CR>') -- Directory

-- Visual Indentation (Reselect after indent)
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<Tab>", ">")
vim.keymap.set("v", "<S-Tab>", "<")

-- Window Navigation
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- Buffer/Tab Navigation
vim.keymap.set("n", "<leader><Tab>", "<c-^>") -- Switch to last buffer
vim.keymap.set("c", "<tab>", "<C-z>") -- Fix for CMP?

-- Window Resizing
vim.keymap.set("", "+", "3<c-w>>")
vim.keymap.set("", "-", "3<c-w><")

-- HTML Wrappers
vim.keymap.set("v", "<leader><leader>b", "<S-S><strong>")
vim.keymap.set("v", "<leader><leader>i", "<S-S><em>")

-- Misc
vim.keymap.set("n", "S", "mzi<CR><ESC>`z") -- Split line, preserve cursor
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>") -- Terminal escape

-- Disable swapfiles (Fixes W325 error and improves performance)
vim.opt.swapfile = false

-- Enable persistent undo (Keeps undo history between sessions)
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- ==========================================================================
--  PLUGIN CONFIGS
-- ==========================================================================

-- Ack
vim.g.ackprg = "rg --vimgrep --pcre2 -i"

-- Setup files (Ensure these files exist in lua/setup/)
-- These should NOT contain 'vim.cmd' wrappers if possible.
require("setup.ai-toggle")
require("setup.theme-toggle")
