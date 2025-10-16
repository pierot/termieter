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
	"projekt0n/github-nvim-theme",
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
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = true, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
				theme = "wave", -- Load "wave" theme
				background = { -- map the value of 'background' option to a theme
					dark = "dragon", -- try "dragon" !
					light = "lotus",
				},
			})

			-- vim.cmd("colorscheme ayu-dark")
			vim.cmd("colorscheme kanagawa")
		end,
	},
}
-- return {}
