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
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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

			-- Integration with nvim-cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
				"dockerfile",
				"eex",
				"elixir",
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
				"scss",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			})

			-- Enable treesitter highlighting for filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"bash",
					"c",
					"css",
					"dockerfile",
					"eelixir",
					"elixir",
					"gitignore",
					"haskell",
					"heex",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"php",
					"scss",
					"toml",
					"typescript",
					"typescriptreact",
					"vim",
					"yaml",
				},
				callback = function()
					vim.treesitter.start()
				end,
			})

			-- Enable treesitter-based indentation
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "elixir", "heex", "eelixir", "javascript", "typescript", "lua", "python" },
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
		priority = 1000,
		keys = {
			{ "<c-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
			{ "R", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file tree" },
		},
		config = function()
			local nvimtree = require("nvim-tree")
			nvimtree.setup({
				hijack_directories = { enable = true, auto_open = true },
				diagnostics = { enable = true },
				view = { width = 43 },
			})

			-- Auto-open nvim-tree when opening a directory
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
			"hrsh7th/cmp-nvim-lsp",
			-- { "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			-- import cmp-nvim-lsp plugin
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = cmp_nvim_lsp.default_capabilities()

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
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "Show references" })
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
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1 })
					end, { buffer = args.buf, desc = "Previous diagnostic" })
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1 })
					end, { buffer = args.buf, desc = "Next diagnostic" })
				end,
			})

			vim.lsp.enable({ "html", "emmet_ls", "cssls", "tailwindcss", "ts_ls", "lua_ls", "expert" })
		end,
	},

	-- Completion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- Load VSCode-style snippets
			require("luasnip/loaders/from_vscode").lazy_load()

			vim.opt.completeopt = "menu,menuone,noselect"

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP
					{ name = "luasnip" }, -- Snippets
					{ name = "buffer" }, -- Buffer text
					{ name = "path" }, -- File paths
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						preset = "codicons",
						maxwidth = 50,
						ellipsis_char = "...",
						symbol_map = {
							Text = "󰉿",
							Method = "󰆧",
							Function = "󰊕",
							Constructor = "",
							Field = "󰜢",
							Variable = "󰀫",
							Class = "󰠱",
							Interface = "",
							Module = "",
							Property = "󰜢",
							Unit = "󰑭",
							Value = "󰎠",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "󰏘",
							File = "󰈙",
							Reference = "󰈇",
							Folder = "󰉋",
							EnumMember = "",
							Constant = "󰏿",
							Struct = "󰙅",
							Event = "",
							Operator = "󰆕",
							TypeParameter = "",
						},
					}),
				},
			})
		end,
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

			-- Color table
			local colors = {
				bg = "#181d24",
				fg = "#e4e6e8",
				yellow = "#ECBE7B",
				cyan = "#008080",
				darkblue = "#081633",
				green = "#98be65",
				orange = "#FF8800",
				violet = "#a9a1e1",
				magenta = "#c678dd",
				blue = "#51afef",
				red = "#ec5f67",
			}

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			local config = {
				options = {
					component_separators = "",
					section_separators = "",
					theme = {
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			local function removeDuplicates(tbl)
				local unique = {}
				local result = {}
				for _, v in ipairs(tbl) do
					if not unique[v] then
						table.insert(result, v)
						unique[v] = true
					end
				end
				return result
			end

			ins_left({
				function()
					return "▊"
				end,
				color = { fg = colors.blue },
				padding = { left = 0, right = 1 },
			})

			ins_left({
				function()
					return ""
				end,
				color = function()
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						[""] = colors.blue,
						V = colors.blue,
						c = colors.magenta,
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						[""] = colors.orange,
						ic = colors.yellow,
						R = colors.violet,
						Rv = colors.violet,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { right = 1 },
			})

			ins_left({ "filesize", cond = conditions.buffer_not_empty })
			ins_left({
				"filename",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.magenta, gui = "bold" },
			})
			ins_left({ "location" })
			ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })
			ins_left({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				diagnostics_color = {
					error = { fg = colors.red },
					warn = { fg = colors.yellow },
					info = { fg = colors.cyan },
				},
			})

			ins_left({
				function()
					return "%="
				end,
			})

			ins_left({
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_clients()
					if next(clients) == nil then
						return msg
					end
					local all = {}
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							table.insert(all, client.name)
						end
					end
					if next(all) == nil then
						return msg
					end
					all = removeDuplicates(all)
					return table.concat(all, ", ")
				end,
				icon = " LSP:",
				color = { fg = "#ffffff", gui = "bold" },
			})

			ins_right({
				"o:encoding",
				fmt = string.upper,
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = "bold" },
			})
			ins_right({
				"fileformat",
				fmt = string.upper,
				icons_enabled = false,
				color = { fg = colors.green, gui = "bold" },
			})
			ins_right({
				"branch",
				icon = "",
				color = { fg = colors.violet, gui = "bold" },
			})
			ins_right({
				"diff",
				symbols = { added = " ", modified = "󰝤 ", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			})
			ins_right({
				function()
					return "▊"
				end,
				color = { fg = colors.blue },
				padding = { left = 1 },
			})

			lualine.setup(config)
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
