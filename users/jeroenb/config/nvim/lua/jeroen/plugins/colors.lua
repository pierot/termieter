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
	"projekt0n/github-nvim-theme",
	{
		"Shatur/neovim-ayu",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local colors = require("ayu.colors")
			colors.generate() -- Pass `true` to enable mirage
			require("ayu").setup({
				overrides = {
					Normal = { bg = "None" },
					NormalFloat = { bg = "none" },
					ColorColumn = { bg = "#11151C" },
					SignColumn = { bg = "None" },
					Folded = { bg = "None" },
					FoldColumn = { bg = "None" },
					CursorLine = { bg = "#11151C" },
					CursorColumn = { bg = "None" },
					VertSplit = { bg = "None" },
					Visual = { fg = colors.bg, bg = colors.special },
					TelescopeMatching = { fg = "#0090ff" },
				},
			})
			vim.cmd("colorscheme ayu-dark")
		end,
	},
}
-- return {}
