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
				"dockerfile",
				"eex",
				"elixir",
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
				"scss",
				"surface",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			})

			-- Use the json parser for jsonc files (no separate jsonc parser on main).
			vim.treesitter.language.register("json", "jsonc")

			-- Compat shim: telescope.nvim (and some other plugins) still call
			-- master-branch APIs from nvim-treesitter that don't exist on main.
			-- Remove once telescope is replaced or patched upstream.
			do
				local ok_p, parsers = pcall(require, "nvim-treesitter.parsers")
				if ok_p and type(parsers) == "table" then
					if not parsers.ft_to_lang then
						parsers.ft_to_lang = function(ft)
							return vim.treesitter.language.get_lang(ft) or ft
						end
					end
					if not parsers.get_parser then
						parsers.get_parser = function(bufnr, lang)
							local o, p = pcall(vim.treesitter.get_parser, bufnr, lang)
							return o and p or nil
						end
					end
				end

				local ok_c, configs = pcall(require, "nvim-treesitter.configs")
				if not ok_c or type(configs) ~= "table" then
					package.loaded["nvim-treesitter.configs"] = {}
					configs = package.loaded["nvim-treesitter.configs"]
				end
				if not configs.is_enabled then
					configs.is_enabled = function(_mod, lang, _bufnr)
						if not lang or lang == "" then
							return false
						end
						return pcall(vim.treesitter.language.add, lang)
					end
				end
				if not configs.get_module then
					configs.get_module = function(_name)
						return { additional_vim_regex_highlighting = false }
					end
				end

				local ok_u, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
				if not ok_u or type(ts_utils) ~= "table" then
					package.loaded["nvim-treesitter.ts_utils"] = {}
					ts_utils = package.loaded["nvim-treesitter.ts_utils"]
				end
				if not ts_utils.repeated_table then
					ts_utils.repeated_table = function(n, val)
						local t = {}
						for i = 1, n do
							t[i] = val
						end
						return t
					end
				end
			end

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
