return {
	"saghen/blink.cmp",
	-- v1 is the stable line; v2 is mid-breaking-changes and needs an extra blink.lib dep.
	version = "1.*",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				-- load friendly-snippets into LuaSnip so blink's luasnip preset sees them
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	opts = {
		-- Keymap mirrors the old nvim-cmp binds. preset "none" = fully explicit.
		keymap = {
			preset = "none",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
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
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
		},
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
