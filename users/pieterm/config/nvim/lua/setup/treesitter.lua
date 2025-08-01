local setup, ts = pcall(require, "nvim-treesitter.configs")
if not setup then
	return
end

ts.setup({
	highlight = {
		enable = true,
		disable = function(lang, bufnr) -- Disable in large C++ buffers
			return lang == "sql" and vim.api.nvim_buf_line_count(bufnr) > 1000
		end,
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
		max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
	},
	-- enable indentation
	indent = { enable = true },
	textobjects = {
		enable = true,
	},
	-- ensure these language parsers are installed
	ensure_installed = {
		"bash",
		"c",
		"css",
		"css",
		"dockerfile",
		"elixir",
		"gitignore",
		"haskell",
		"heex",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"jsonc",
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
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
	refactor = {
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = true },
		smart_rename = {
			enable = true,
			keymaps = { smart_rename = "grr" },
			navigation = {
				enable = true,
				keymaps = {
					goto_definition = "gnd",
					list_definitions = "gnD",
					list_definitions_toc = "gO",
					goto_next_usage = "<a-*>",
					goto_previous_usage = "<a-#>",
				},
			},
		},
	},
})
