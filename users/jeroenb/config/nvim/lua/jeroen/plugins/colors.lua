function ToggleTheme()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end

return {
	"rktjmp/lush.nvim",
	"metalelf0/jellybeans-nvim",
	"gruvbox-community/gruvbox",
	"rebelot/kanagawa.nvim",
	"folke/tokyonight.nvim",
	"projekt0n/github-nvim-theme",
	"EdenEast/nightfox.nvim",
	"nyoom-engineering/oxocarbon.nvim",
	{
		"Shatur/neovim-ayu",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- local colors = require("ayu.colors")
			-- colors.generate() -- Pass `true` to enable mirage
			-- require("ayu").setup({
			-- 	overrides = {
			-- 		Normal = { bg = "None" },
			-- 		NormalFloat = { bg = "none" },
			-- 		ColorColumn = { bg = "#11151C" },
			-- 		SignColumn = { bg = "None" },
			-- 		Folded = { bg = "None" },
			-- 		FoldColumn = { bg = "None" },
			-- 		CursorLine = { bg = "#11151C" },
			-- 		CursorColumn = { bg = "None" },
			-- 		VertSplit = { bg = "None" },
			-- 		Visual = { fg = colors.bg, bg = colors.special },
			-- 		TelescopeMatching = { fg = "#0090ff" },
			-- 	},
			-- })

			-- Default options:
			-- require("kanagawa").setup({
			-- 	compile = false, -- enable compiling the colorscheme
			-- 	undercurl = true, -- enable undercurls
			-- 	commentStyle = { italic = true },
			-- 	functionStyle = {},
			-- 	keywordStyle = { italic = true },
			-- 	statementStyle = { bold = true },
			-- 	typeStyle = {},
			-- 	transparent = true, -- do not set background color
			-- 	dimInactive = true, -- dim inactive window `:h hl-NormalNC`
			-- 	terminalColors = true, -- define vim.g.terminal_color_{0,17}
			-- 	colors = { -- add/modify theme and palette colors
			-- 		palette = {},
			-- 		theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			-- 	},
			-- 	overrides = function(colors) -- add/modify highlights
			-- 		return {}
			-- 	end,
			-- 	theme = "wave", -- Load "wave" theme
			-- 	background = { -- map the value of 'background' option to a theme
			-- 		dark = "dragon", -- try "dragon" !
			-- 		light = "lotus",
			-- 	},
			-- })

			-- Palettes are the base color defines of a colorscheme.
			-- You can override these palettes for each colorscheme defined by nightfox.
			local palettes = {
				-- Everything defined under `all` will be applied to each style.
				all = {},
				carbonfox = {
					-- A palette also defines the following:
					--   bg0, bg1, bg2, bg3, bg4, fg0, fg1, fg2, fg3, sel0, sel1, comment
					bg0 = "#000000",
					bg1 = "#000000",

					-- comment is the definition of the comment color.
					comment = "#fec47c",
				},
			}

			local groups = {
				carbonfox = {
					NeogitDiffAdd = { fg = "palette.green.bright", bg = "#0a2a0a" },
					NeogitDiffAddHighlight = { fg = "palette.green.bright", bg = "#0a2a0a" },
					NeogitDiffDelete = { fg = "palette.red.bright", bg = "#2a0a0a" },
					NeogitDiffDeleteHighlight = { fg = "palette.red.bright", bg = "#2a0a0a" },
				},
			}

			require("nightfox").setup({ palettes = palettes, groups = groups })

			-- vim.cmd("colorscheme ayu-dark")
			vim.cmd("colorscheme carbonfox")
		end,
	},
}
-- return {}
