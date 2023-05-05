-------------------- HELPERS -------------------------------
local u = require("utils")

-- Install plugins automatically
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Upon initial vim install, install packer & plugins
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

	use 'lewis6991/impatient.nvim'                      -- faster startup
	use 'kyazdani42/nvim-tree.lua'                      -- sidebar file explorer
	use 'kyazdani42/nvim-web-devicons'                  -- web dev icons used by many plugins

	use 'nvim-lua/popup.nvim'                           -- ui plugin used by many, someday upstream in neovim
	use 'nvim-lua/plenary.nvim'                         -- ui plugin used by many, someday upstream in neovim

	-- 'blackCauldron7/surround.nvim'
	use 'tpope/vim-surround'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
	-- use 'neovimhaskell/haskell-vim'
	use 'vim-test/vim-test'
  use 'junegunn/vim-easy-align'

	-- use 'jeffkreeftmeijer/vim-numbertoggle'

  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  -- use 'norcalli/nvim-colorizer.lua'

	use {'nvim-treesitter/nvim-treesitter'}             -- treesitter, code highlighting, last

	use 'docunext/closetag.vim'
	use 'mattn/emmet-vim'
	use 'kana/vim-textobj-user'
	use 'kana/vim-textobj-line'
	-- use 'andyl/vim-textobj-elixir'
	use 'elixir-editors/vim-elixir'                     -- correct commentstring and other percs

	use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'               -- Use Neovim as a LS to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim'                     -- Prettier plugin for Neovim's built-in LSP client
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use "jayp0521/mason-null-ls.nvim"
  use 'jose-elias-alvarez/typescript.nvim'

  use({
    "nvimdev/lspsaga.nvim",
    opt = true,
    branch = "main",
    event = "LspAttach",
    requires = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"}
    }
  })

  use {                                               -- pretty lsp diagnostics
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons"
  }

  use 'onsails/lspkind-nvim'                          -- vscode-like pictograms

	use 'hrsh7th/nvim-cmp'                              -- autocomplete
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-nvim-lsp'

  -- snippets
  -- use 'L3MON4D3/LuaSnip'
  -- use 'saadparwaiz1/cmp_luasnip'
  -- use 'rafamadriz/friendly-snippets'

	use 'nvim-lualine/lualine.nvim'

	-- Telescope
	use 'nvim-telescope/telescope.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

	use 'mileszs/ack.vim'
	use 'b3nj5m1n/kommentary'                           -- Comment

	-- Themes
	-- 'rktjmp/lush.nvim'
	-- 'metalelf0/jellybeans-nvim'
	use 'folke/tokyonight.nvim'												 -- Used for lualine and theme
	use 'norcalli/nvim-colorizer.lua'
	-- 'gruvbox-community/gruvbox'
	-- 'kovetskiy/sxhkd-vim'
	-- 'joshdick/onedark.vim'

  use {'github/copilot.vim'}

  if packer_bootstrap then
    require('packer').sync()
  end
end)
