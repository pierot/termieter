-------------------- HELPERS -------------------------------
-- Install plugins automatically using native autocmd API
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "plugins.lua",
	group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
	callback = function()
		vim.cmd("source <afile>")
		vim.cmd("PackerSync")
	end,
})

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

	use("nvim-tree/nvim-web-devicons") -- web dev icons used by many plugins

	use("nvim-lua/plenary.nvim") -- for asynchronous programming using coroutines
	-- use("nvim-lua/popup.nvim") -- ui plugin used by many, someday upstream in neovim
	use("rcarriga/nvim-notify")
	use("MunifTanjim/nui.nvim")
	use("folke/noice.nvim") -- replaces the UI for messages, cmdline and the popupmenu
	use("folke/trouble.nvim") -- pretty lsp diagnostics
	use("folke/snacks.nvim")

	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-unimpaired")
	use("junegunn/vim-easy-align")
	use("lambdalisue/suda.vim")

	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	use({ "nvim-treesitter/nvim-treesitter" }) -- treesitter, code highlighting, last

	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")

	-- use("mattn/emmet-vim")
	use("kana/vim-textobj-user")
	use("kana/vim-textobj-line")

	-- use("elixir-editors/vim-elixir") -- correct commentstring and other percs

	-- Elixir LSP (ExpertLS)
	use({
		"elixir-tools/elixir-tools.nvim",
		tag = "stable",
		requires = { "nvim-lua/plenary.nvim" },
		ft = { "elixir", "eex", "heex", "surface" }, -- Load for Elixir and template files
		config = function()
			local elixir = require("elixir")
			elixir.setup({
				nextls = { enable = false }, -- NextLS disabled, using ExpertLS instead
				credo = {}, -- Credo linter enabled with defaults
				elixirls = { enable = false }, -- Old ElixirLS disabled, using ExpertLS instead
			})
		end,
	})

	use("kyazdani42/nvim-tree.lua") -- sidebar file explorer

	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp") -- LSP completion source for nvim-cmp

	use("stevearc/conform.nvim") -- Lightweight yet powerful formatter plugin for Neovim
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	-- use("MunifTanjim/prettier.nvim") -- Prettier plugin for Neovim's built-in LSP client
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jayp0521/mason-null-ls.nvim")

	use("hrsh7th/nvim-cmp") -- autocomplete
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")

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
	use({
		"Exafunction/codeium.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_chat = true,
				virtual_text = {
					enabled = true,
					manual = false,
					filetypes = {},
					default_filetype_enabled = true,
					idle_delay = 75,
					virtual_text_priority = 65535,
					map_keys = true,
					key_bindings = {
						accept = "<Tab>", -- Accept ghost text with Tab (works with cmp fallback)
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						clear = "<C-]>",
					}
				}
			})
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
