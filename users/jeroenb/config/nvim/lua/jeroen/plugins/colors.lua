function ToggleTheme()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end

return {
	-- "rktjmp/lush.nvim",
	"metalelf0/jellybeans-nvim",
	"norcalli/nvim-colorizer.lua",
	"Shatur/neovim-ayu",
	"gruvbox-community/gruvbox",
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				-- ...
			})

			vim.cmd("colorscheme github_dark_high_contrast")
		end,
	},
}
