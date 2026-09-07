return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			require("nvim-treesitter").install({
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
				"hcl",
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
				"surface",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			})

			-- Use the json parser for jsonc files (no separate jsonc parser on main).
			vim.treesitter.language.register("json", "jsonc")

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local bufnr = args.buf
					if pcall(vim.treesitter.start, bufnr) then
						vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
