return {
	"hrsh7th/nvim-cmp",
	-- event = "VeryLazy",
	-- event = "InsertEnter",
	lazy = false,
	dependencies = {
		"L3MON4D3/LuaSnip", -- snippet engine
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path", -- source for file system paths
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"rafamadriz/friendly-snippets", -- useful snippets
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"petertriho/cmp-git",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		luasnip.config.setup({})

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
				autocomplete = false,
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "git" }, -- git, really??
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})

		-- Vim-vsnip
		-- vim.g.vsnip_filetypes = {
		-- 	javascriptreact = { "javascript" },
		-- 	typescript = { "javascript" },
		-- 	typescriptreact = { "javascript" },
		-- 	elixir = { "elixir" },
		-- 	eelixir = { "eelixir" },
		-- }
	end,
}
