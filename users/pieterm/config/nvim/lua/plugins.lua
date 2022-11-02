-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd'
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

local u = require("utils")

-- Auto install paq-nvim if it doesn't exist
local install_path = '$HOME/.local/share/nvim/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone --depth=1 https://github.com/savq/paq-nvim.git ' .. install_path)
end

require 'paq' {
	'lewis6991/impatient.nvim';                      -- faster startup
	-- "mhartington/formatter.nvim";
	'kyazdani42/nvim-tree.lua';                      -- sidebar file explorer
	'kyazdani42/nvim-web-devicons';                  -- web dev icons used by many plugins

	'nvim-lua/popup.nvim';                           -- ui plugin used by many, someday upstream in neovim
	'nvim-lua/plenary.nvim';                         -- ui plugin used by many, someday upstream in neovim

	-- 'blackCauldron7/surround.nvim';
	'tpope/vim-surround';
	'tpope/vim-fugitive';
	'tpope/vim-repeat';
	-- 'neovimhaskell/haskell-vim';
	'vim-test/vim-test';
  'junegunn/vim-easy-align';

	-- 'jeffkreeftmeijer/vim-numbertoggle';
	'docunext/closetag.vim';
	'mattn/emmet-vim';
	'kana/vim-textobj-user';
	'kana/vim-textobj-line';
	'andyl/vim-textobj-elixir';
	'elixir-editors/vim-elixir';                     -- correct commentstring and other percs

	'neovim/nvim-lspconfig';

	'hrsh7th/nvim-cmp';                              -- autocomplete
	'hrsh7th/cmp-buffer';
	'hrsh7th/cmp-path';
	'hrsh7th/cmp-cmdline';
	'hrsh7th/cmp-nvim-lsp';

	'hrsh7th/cmp-vsnip';                             -- snippets
	'hrsh7th/vim-vsnip';                             -- snippets
	'hrsh7th/vim-vsnip-integ';                       -- snippets
	'rafamadriz/friendly-snippets';                  -- snippets

	'nvim-lualine/lualine.nvim';

	-- Telescope
	'nvim-telescope/telescope.nvim';
	{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'};

	'mileszs/ack.vim';
	'steelsojka/pears.nvim';                         -- Auto Pairs
	'b3nj5m1n/kommentary';                           -- Comment

	-- Themes
	'rktjmp/lush.nvim';
	'metalelf0/jellybeans-nvim';
	'folke/tokyonight.nvim';
	'norcalli/nvim-colorizer.lua';
	'gruvbox-community/gruvbox';
	'kovetskiy/sxhkd-vim';

	{'nvim-treesitter/nvim-treesitter'};             -- treesitter, code highlighting, last
}

-- all small plugins that need nothing more than a simple
-- setup are setup here
require'colorizer'.setup()
require('nvim-web-devicons').setup()
require('pears').setup()                      -- Auto pairs
g.ackprg = 'rg --vimgrep --pcre2'         -- ack
u.map('n', '<leader>gs', '<cmd>Git<CR>')      -- fugitive
