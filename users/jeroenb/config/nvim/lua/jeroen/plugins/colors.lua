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
	{
		"gruvbox-community/gruvbox",
		config = function()
			-- vim.cmd("colorscheme jellybeans-nvim")
			vim.cmd("colorscheme lunaperche")
			vim.keymap.set("n", "<F5>", ":lua ToggleTheme()<CR>") -- Switch between windows by hitting <Tab> twice
		end,
	},
}
