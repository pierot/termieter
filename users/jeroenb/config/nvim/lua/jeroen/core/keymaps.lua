vim.g.mapleader = ","

-- General keymaps
vim.keymap.set("n", "<CR>", ":nohl<CR>") -- Clear search
vim.keymap.set("n", "Q", "<Nop>") -- We don't do ex mode
vim.keymap.set("", ";", ":") -- Map ; to :
vim.keymap.set("n", "<leader>x", "<cmd>set list!<CR>")
vim.keymap.set("n", "S", "mzi<CR><ESC>`z") -- Split line and preserve cursor position
vim.keymap.set("n", "gI", "`.") -- Move to the position where the last change was made

vim.keymap.set("c", "w!!", "<cmd>w !sudo tee % >/dev/null<CR>") -- Write read-only file via sudo
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>") -- Alias to :w

-- Path copy helpers
vim.keymap.set("n", "<leader>cf", '<cmd>let @+=expand("%")<CR>') -- relative path  (src/foo.txt)
vim.keymap.set("n", "<leader>cF", '<cmd>let @+=expand("%:p")<CR>') -- absolute path  (/something/src/foo.txt)
vim.keymap.set("n", "<leader>ct", '<cmd>let @+=expand("%:t")<CR>') -- filename       (foo.txt)
vim.keymap.set("n", "<leader>cd", '<cmd>let @+=expand("%:p:h")<CR>') -- directory name (/something/src)

-- Reselect last selection after indent/un-indent in visual/select modes
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<Tab>", ">")
vim.keymap.set("v", "<S-Tab>", "<")

-- Mappings / Split windows
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-l>", "<c-w>l")

vim.keymap.set("", "+", "3<c-w>>") -- Enlarge splits
vim.keymap.set("", "-", "3<c-w><")

-- Mappings / HTML
vim.keymap.set("v", "<leader><leader>b", "<S-S><strong>")
vim.keymap.set("v", "<leader><leader>i", "<S-S><em>")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Git
vim.keymap.set("n", "<leader>gmh", "<cmd>diffget //2<CR>") -- left
vim.keymap.set("n", "<leader>gml", "<cmd>diffget //3<CR>") -- right
vim.keymap.set("n", "<leader>gk", "<cmd>! gitk %<CR>")

-- Project utils
vim.keymap.set("n", "<leader>ms", "<cmd>! make styles<CR>")

-- inner line
vim.keymap.set("v", "il", "g_o^") -- inner line
vim.keymap.set("v", "al", "$o^") -- outer line

-- $$

-- buffers
vim.keymap.set("n", "tk", ":blast<CR>")
vim.keymap.set("n", "tj", ":bfirst<CR>")
vim.keymap.set("n", "th", ":bprev<CR>")
vim.keymap.set("n", "tl", ":bnext<CR>")
vim.keymap.set("n", "td", ":bdelete<CR>")

-- files
vim.keymap.set("n", "QQ", ":q!<CR>")
vim.keymap.set("n", "WW", ":w!<CR>")

-- splits
vim.keymap.set("n", "<space><space>", "<cmd>set nohlsearch<CR>")
-- Quicker close split
vim.keymap.set("n", "<leader>qq", ":q<CR>", { silent = true, noremap = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Lazy
vim.keymap.set("n", "<leader>lz", "<cmd>:Lazy<CR>")
vim.keymap.set("n", "<leader>lu", "<cmd>:Lazy update<CR>")
