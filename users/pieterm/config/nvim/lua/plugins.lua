-- Neovim plugins configured with lazy.nvim
-- Migrated from Packer to Lazy.nvim

return {
	-- ====================
	-- CORE PLUGINS
	-- ====================

	-- Icons used by many plugins
	"nvim-tree/nvim-web-devicons",

	-- Async library
	"nvim-lua/plenary.nvim",

	-- UI component library
	"MunifTanjim/nui.nvim",

	-- Modern UI for messages, cmdline, and popupmenu
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			local noice = require("noice")
			noice.setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
				views = {
					cmdline_popup = {
						position = {
							row = "40%",
							col = "50%",
						},
						--[[ size = {
        width = 60,
        height = "auto",
      }, ]]
					},
					popupmenu = {
						-- relative = "editor",
						position = {
							row = "40%",
							col = "50%",
						},
						--[[ size = {
        width = 60,
        height = 10,
      }, ]]
						border = {
							style = "rounded",
							padding = { 3, 5 },
						},
						--[[ win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      }, ]]
					},
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "%d+L, %d+B" },
								{ find = "; after #%d+" },
								{ find = "; before #%d+" },
								{ find = "%d fewer lines" },
								{ find = "%d more lines" },
							},
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							find = "Phoenix.LiveView.HTMLFormatter",
						},
						opts = { skip = true },
					},
				},
			})
		end,
	},

	-- Collection of small utilities
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			local snacks = require("snacks")
			snacks.setup({
				bigfile = { enabled = true },
				notifier = { enabled = true },
				quickfile = { enabled = true },
				statuscolumn = { enabled = true },
				words = { enabled = true },
			})
		end,
	},

	-- ====================
	-- TEXT EDITING PLUGINS
	-- ====================

	-- Surround text objects
	"tpope/vim-surround",

	-- Repeat plugin commands
	"tpope/vim-repeat",

	-- Bracket mappings
	"tpope/vim-unimpaired",

	-- Text alignment
	{
		"junegunn/vim-easy-align",
		config = function()
			vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)", { remap = true })
		end,
	},

	-- Sudo write
	"lambdalisue/suda.vim",

	-- Text object user
	"kana/vim-textobj-user",

	-- Text object line (depends on vim-textobj-user)
	{
		"kana/vim-textobj-line",
		dependencies = { "kana/vim-textobj-user" },
	},

	-- Auto-pairing brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
				},
			})
		end,
	},

	-- ====================
	-- TREESITTER
	-- ====================

	-- Syntax highlighting and parsing
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false, -- v1.0+ does not support lazy-loading
		branch = "main",
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			-- Install parsers (v1.0+ API)
			ts.install({
				"bash",
				"c",
				"css",
				"diff",
				"dockerfile",
				"eex",
				"elixir",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"haskell",
				"heex",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"php",
				"query",
				"regex",
				"scss",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			})

			-- Enable treesitter highlighting for every filetype with an installed parser
			-- (vim.treesitter.start raises an error when there is none)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})

			-- Enable treesitter-based indentation
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "elixir", "heex", "eelixir", "javascript", "typescript", "lua" },
				callback = function()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},

	-- Auto-close tags
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			local autotag = require("nvim-ts-autotag")
			autotag.setup()
		end,
	},

	-- ====================
	-- GIT INTEGRATION
	-- ====================

	-- Git commands
	{
		"tpope/vim-fugitive",
		lazy = true,
		cmd = { "Git", "G" },
	},

	-- Git signs in gutter
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true,
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
			})
		end,
	},

	-- ====================
	-- FILE EXPLORER
	-- ====================

	{
		"kyazdani42/nvim-tree.lua",
		lazy = true,
		keys = {
			{ "<c-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
			{ "R", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file tree" },
		},
		init = function()
			-- Auto-open nvim-tree when opening a directory.
			-- In init, not config: config only runs once the plugin is loaded.
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function(data)
					local directory = vim.fn.isdirectory(data.file) == 1
					if directory then
						vim.cmd.cd(data.file)
						require("nvim-tree.api").tree.open()
					end
				end,
			})
		end,
		config = function()
			local nvimtree = require("nvim-tree")
			nvimtree.setup({
				hijack_directories = { enable = true, auto_open = true },
				diagnostics = { enable = true },
				view = { width = 43 },
			})
		end,
	},

	-- ====================
	-- LSP & COMPLETION
	-- ====================

	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		-- enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
			-- { "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- vim.lsp.config("*", {
			-- 	root_markers = { ".git" },
			-- })

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Small manual override for emmet_ls to add .heex support
			vim.lsp.config.emmet_ls = {
				filetypes = { "html", "css", "eelixir", "heex" },
			}

			vim.lsp.config("expert", {
				cmd = { "expert", "--stdio" },
				root_markers = { "mix.exs", ".git" },
				filetypes = { "elixir", "eelixir", "heex" },
			})

			-- LSP keymaps (set when LSP attaches to buffer)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf, silent = true }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
					vim.keymap.set(
						"n",
						"gD",
						vim.lsp.buf.declaration,
						{ buffer = args.buf, desc = "Go to declaration" }
					)
					vim.keymap.set(
						"n",
						"gi",
						vim.lsp.buf.implementation,
						{ buffer = args.buf, desc = "Go to implementation" }
					)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover documentation" })
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename symbol" })
					vim.keymap.set(
						{ "n", "v" },
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = args.buf, desc = "Code action" }
					)
					vim.keymap.set(
						"n",
						"<leader>d",
						vim.diagnostic.open_float,
						{ buffer = args.buf, desc = "Line diagnostics" }
					)

					-- Show LSP document colors (e.g. tailwind classes) as a virtual
					-- swatch next to the text instead of painting the background
					vim.lsp.document_color.enable(true, { bufnr = args.buf }, { style = "virtual" })
				end,
			})

			vim.lsp.enable({ "html", "emmet_ls", "cssls", "tailwindcss", "ts_ls", "lua_ls", "expert" })
		end,
	},

	-- Snippet engine.
	-- Not a blink.cmp dependency, so it stays out of startup: blink's luasnip
	-- preset requires it on the first completion, and lazy.nvim loads it then.
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		config = function()
			-- Load VSCode-style snippets
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
	},

	-- Completion engine
	{
		"saghen/blink.cmp",
		-- v1 is the stable line; v2 has breaking changes.
		version = "1.*",
		opts = {
			-- Keymap mirrors the old nvim-cmp binds. preset "none" = fully explicit.
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-y>"] = { "accept", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			appearance = { nerd_font_variant = "mono" },
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			completion = {
				-- No preselect: <CR> only accepts an item you selected (nvim-cmp select = false)
				list = { selection = { preselect = false } },
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
			},
			-- The command line keeps the native wildmenu
			cmdline = { enabled = false },
			-- Signature help stays with noice (blink's signature is off by default)
		},
		opts_extend = { "sources.default" },
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufNewFile", "BufReadPre", "BufWritePre" },
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters = {
					-- Projects that export MIX_DEBUG=1 make `mix format` print
					-- its "-> Running mix ..." trace on stdout, which conform
					-- then writes into the buffer around the formatted file.
					mix = { env = { MIX_DEBUG = "0" } },
				},
				formatters_by_ft = {
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
					lua = { "stylua" },
					elixir = { "mix" },
					heex = { "mix" },
				},
				format_on_save = {
					lsp_format = "fallback",
					async = false,
					timeout_ms = 1500,
				},
			})
		end,
	},

	-- ====================
	-- LANGUAGE TOOLS
	-- ====================

	-- Mason installer
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		config = function()
			local mason = require("mason")
			mason.setup({})
		end,
	},

	-- Mason LSP config integration
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			local lspconfig = require("mason-lspconfig")
			lspconfig.setup({
				-- Only the servers that vim.lsp.enable() actually starts.
				-- ts_ls is omitted on purpose: typescript-language-server is
				-- already installed globally through yarn.
				ensure_installed = {
					"cssls",
					"emmet_ls",
					"html",
					"lua_ls",
					"tailwindcss",
				},
				-- Servers are started from the explicit vim.lsp.enable() list.
				-- Without this, mason-lspconfig also enables everything it finds
				-- installed, so that list stops being the single source of truth.
				automatic_enable = false,
			})
		end,
	},

	-- ====================
	-- UI PLUGINS
	-- ====================

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local lualine = require("lualine")
			local lazy_status = require("lazy.status") -- to configure lazy pending updates count

			lualine.setup({
				options = {
					-- follow the active colorscheme, so the F5 toggle also restyles the statusline
					theme = "auto",
				},
				sections = {
					lualine_x = {
						{
							lazy_status.updates,
							cond = lazy_status.has_updates,
							color = { fg = "#ff9e64" },
						},
						{ "encoding" },
						{ "fileformat" },
						{ "filetype" },
					},
				},
			})
		end,
	},

	-- Color highlighter.
	-- norcalli's original stopped at 2021-04-28 and calls the removed
	-- vim.tbl_flatten. catgoose maintains the fork and keeps the old
	-- option names as aliases, so the settings below are unchanged.
	{
		"catgoose/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local colorizer = require("colorizer")
			colorizer.setup({
				filetypes = { "*" },
				user_default_options = {
					RGB = true,
					RRGGBB = true,
					names = true,
					RRGGBBAA = true,
					rgb_fn = true,
					hsl_fn = true,
					css = true,
					css_fn = true,
				},
			})
		end,
	},

	-- ====================
	-- SEARCH/NAVIGATION
	-- ====================

	-- Telescope fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{ "<c-p>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
			{ "<leader>b", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
			{ "<leader>ff", "<cmd>Telescope grep_string<CR>", desc = "Grep string" },
			{ "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "truncate" },
					file_ignore_patterns = {
						"node_modules",
						"vendor",
						"**/*.min.js",
						"priv/static/js",
						"*.svg",
						"flow-typed",
					},
					vimgrep_arguments = {
						"rg",
						"-i",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--glob=!**/.git/*",
						"--glob=!**/node_modules/*",
						"--glob=!**/vendor/*",
						"--glob=!**/*.min.js",
						"--glob=!**/*.svg",
						"--glob=!**/flow-typed/*",
					},
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
					},
				},
				pickers = {
					find_files = {
						theme = "ivy",
						find_command = {
							"fd",
							"--type",
							"f",
							"--hidden",
							"--exclude",
							".git",
							"--exclude",
							"node_modules",
							"--exclude",
							"flow-typed",
						},
					},
					buffers = {
						theme = "ivy",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			telescope.load_extension("fzf")
		end,
	},

	-- Ack/ripgrep integration
	{
		"mileszs/ack.vim",
		cmd = "Ack",
	},

	-- Commenting uses the built-in gc/gcc (Neovim 0.10+).

	-- ====================
	-- THEMES
	-- ====================

	-- Theme: Nightfox (active)
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local nightfox = require("nightfox")
			nightfox.setup({
				options = {
					transparent = false,
					terminal_colors = true,
					dim_inactive = false,
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "italic,bold",
					},
				},
				palettes = {
					nightfox = {
						bg1 = "#141d28",
						fg1 = "#e4e6e8",
					},
				},
			})

			-- Set colorscheme to nightfox (dark variant)
			vim.cmd("colorscheme nightfox")
		end,
	},
}
