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
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("lewis6991/impatient.nvim") -- faster startup
	use("nvim-tree/nvim-web-devicons") -- web dev icons used by many plugins

	use("nvim-lua/plenary.nvim") -- for asynchronous programming using coroutines
	use("nvim-lua/popup.nvim") -- ui plugin used by many, someday upstream in neovim
	use("rcarriga/nvim-notify")
	use("MunifTanjim/nui.nvim")
	use("folke/noice.nvim") -- replaces the UI for messages, cmdline and the popupmenu
	use("folke/trouble.nvim") -- pretty lsp diagnostics
	use("folke/snacks.nvim") 

	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-unimpaired")
	-- use 'vim-test/vim-test'
	use("junegunn/vim-easy-align")
	use("lambdalisue/suda.vim")

	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	use({ "nvim-treesitter/nvim-treesitter" }) -- treesitter, code highlighting, last

	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")

	use("docunext/closetag.vim")
	use("mattn/emmet-vim")
	use("kana/vim-textobj-user")
	use("kana/vim-textobj-line")

	use("elixir-editors/vim-elixir") -- correct commentstring and other percs
	use("jose-elias-alvarez/typescript.nvim")

	use("kyazdani42/nvim-tree.lua") -- sidebar file explorer

	use("neovim/nvim-lspconfig")
	use("stevearc/conform.nvim") -- Lightweight yet powerful formatter plugin for Neovim
	-- use 'nvimtools/none-ls.nvim'                        -- Use Neovim as a LS to inject LSP diagnostics, code actions, and more via Lua
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	use("MunifTanjim/prettier.nvim") -- Prettier plugin for Neovim's built-in LSP client
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jayp0521/mason-null-ls.nvim")

	use("hrsh7th/nvim-cmp") -- autocomplete
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")

	use("nvim-lualine/lualine.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use("mileszs/ack.vim")
	use("b3nj5m1n/kommentary") -- Comment

	-- Themes
	use("olimorris/onedarkpro.nvim")
	use("EdenEast/nightfox.nvim")
	use("folke/tokyonight.nvim") -- Used for lualine and theme
	use("norcalli/nvim-colorizer.lua")

  -- AI
	use({ "github/copilot.vim" })
	use({ "olimorris/codecompanion.nvim" })
	use({ "GeorgesAlkhouri/nvim-aider" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
