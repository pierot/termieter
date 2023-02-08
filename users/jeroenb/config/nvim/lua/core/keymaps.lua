vim.g.mapleader = ","

-- General keymaps
vim.keymap.set("n", "<CR>", ":nohl<CR>") 			                        -- Clear search
vim.keymap.set('n', 'Q', '<Nop>')                                     -- We don't do ex mode
vim.keymap.set('', ';', ':')                                          -- Map ; to :
vim.keymap.set('n', '<leader>l', ':set list!<CR>')                    -- Toggle invisible characters
vim.keymap.set('n', 'S', 'mzi<CR><ESC>`z')                            -- Split line and preserve cursor position
vim.keymap.set('n', 'gI', '`.')                                       -- Move to the position where the last change was made

vim.keymap.set('c', 'w!!', '<cmd>w !sudo tee % >/dev/null<CR>')       -- Write read-only file via sudo
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>')                        -- Alias to :w

-- Path copy helpers
vim.keymap.set('n', '<leader>cf', '<cmd>let @+=expand("%")<CR>')      -- relative path  (src/foo.txt)
vim.keymap.set('n', '<leader>cF', '<cmd>let @+=expand("%:p")<CR>')    -- absolute path  (/something/src/foo.txt)
vim.keymap.set('n', '<leader>ct', '<cmd>let @+=expand("%:t")<CR>')    -- filename       (foo.txt)
vim.keymap.set('n', '<leader>cd', '<cmd>let @+=expand("%:p:h")<CR>')  -- directory name (/something/src)

-- Reselect last selection after indent/un-indent in visual/select modes
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<Tab>', '>')
vim.keymap.set('v', '<S-Tab>', '<')

-- Mappings / Split windows
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-l>', '<c-w>l')

vim.keymap.set('n', '<silent> <Tab><Tab>', '<C-w>w')             -- Switch between windows by hitting <Tab> twice
vim.keymap.set('n', '<leader><Tab>', '<c-^>')                    -- Switch between last two files

vim.keymap.set('','+', '3<c-w>>')                                -- Enlarge splits
vim.keymap.set('', '-', '3<c-w><')

-- Mappings / HTML
vim.keymap.set('v', '<leader><leader>b', '<S-S><strong>')
vim.keymap.set('v', '<leader><leader>i', '<S-S><em>')

vim.keymap.set('n', 'S', 'mzi<CR><ESC>`z')                       -- Split line and preserve cursor position

vim.cmd 'autocmd BufWritePost *.exs,*.ex silent :!source .env && mix format --check-equivalent %'
 
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- vim-maximizer
vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
vim.keymap.set('n', '<c-n>', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('n', 'R', '<cmd>NvimTreeRefresh<CR>')

-- telescope
vim.keymap.set('n', '<c-p>', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<CR>')
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<CR>')
-- vim.keymap.set('n', '<leader>gss', '<cmd>Telescope git_status<CR>')

-- fugitive
vim.keymap.set('n', '<leader>gs', '<cmd>Git<CR>')

-- Ack
vim.keymap.set('n', '<leader>a', ':Ack<space>')

-- lspsaga
--[[ local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts) ]]

-- Packer
vim.keymap.set('n', '<leader>ps', '<cmd>PackerSync<CR>')
