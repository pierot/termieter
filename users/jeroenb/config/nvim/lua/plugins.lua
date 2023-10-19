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

  -- My plugins here
   
  -- Utils
	use 'lewis6991/impatient.nvim'                      -- faster startup
	use 'nvim-lua/popup.nvim'                           -- ui plugin used by many, someday upstream in neovim
	use 'nvim-lua/plenary.nvim'                         -- ui plugin used by many, someday upstream in neovim
	use 'mileszs/ack.vim'
  use 'github/copilot.vim'                            -- take a guess
  use {
    'f-person/git-blame.nvim',                        -- show blame info
    lazy = true
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {                                               -- pretty lsp diagnostics
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
	
  -- filetree
	use {
    'kyazdani42/nvim-tree.lua',                       -- sidebar file explorer
    lazy=true 
  }      
	use 'kyazdani42/nvim-web-devicons'                  -- web dev icons used by many plugins
	use {'nvim-treesitter/nvim-treesitter'}             -- treesitter, code highlighting, last
	use 'b3nj5m1n/kommentary'                           -- commenting
	use "szw/vim-maximizer"				                      -- maximizes and restores current window

  -- statusline
	use 'nvim-lualine/lualine.nvim'

	-- tpope, always
	use 'tpope/vim-surround'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'

	-- fuzzy finding
	use 'nvim-telescope/telescope.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

  -- atuocompletion
	use 'hrsh7th/nvim-cmp'                              
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'

  -- snippets
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"

	-- Themes
	use 'rktjmp/lush.nvim'
	use 'metalelf0/jellybeans-nvim'
	use 'folke/tokyonight.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use 'gruvbox-community/gruvbox'  
  use 'catppuccin/nvim'
-- use { "catppuccin/nvim", as = "catppuccin" }

  -- managing & installing lsp servers
  use {'williamboman/mason.nvim', lazy=true} 
  use {'williamboman/mason-lspconfig.nvim', lazy=true}

  -- configuring lsp servers
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'              
  use 'jose-elias-alvarez/typescript.nvim'
  use 'nvimdev/lspsaga.nvim'                          -- LSP UI
  use 'onsails/lspkind-nvim'                          -- vscode-like pictograms
  use {                                               -- elixir lsp / formatter / credo lsp
    "elixir-tools/elixir-tools.nvim", 
    tag = "stable", 
    requires = { "nvim-lua/plenary.nvim" }
  }

-- formatting & linting
  use "jayp0521/mason-null-ls.nvim"
  use 'jose-elias-alvarez/null-ls.nvim'               -- use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  -- use 'MunifTanjim/prettier.nvim'                     -- Prettier plugin for Neovim's built-in LSP client

  -- text objects
	use 'kana/vim-textobj-user'
	use 'kana/vim-textobj-line'
	-- use 'andyl/vim-textobj-elixir'
	use 'elixir-editors/vim-elixir'                     -- correct commentstring and other percs
  use 'junegunn/vim-easy-align'

  -- auto closing
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  -- html
	use 'mattn/emmet-vim'
	use 'docunext/closetag.vim'

	use 'jeffkreeftmeijer/vim-numbertoggle'

  -- tmux integration
  use 'christoomey/vim-tmux-navigator'

--[[

	-- 'blackCauldron7/surround.nvim'; 
	use 'neovimhaskell/haskell-vim'
	use 'vim-test/vim-test'

	use 'hrsh7th/cmp-vsnip'                             -- snippets
	use 'hrsh7th/vim-vsnip'                             -- snippets
	use 'hrsh7th/vim-vsnip-integ'                       -- snippets
]]

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

