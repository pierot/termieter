-- carbonfox has no light variant, so toggling 'background' alone did nothing.
-- Switch the colorscheme itself: carbonfox (dark) <-> dayfox (light).
function ToggleTheme()
	if vim.o.background == "dark" then
		vim.cmd("colorscheme dayfox")
	else
		vim.cmd("colorscheme carbonfox")
	end
end

vim.keymap.set("n", "<F5>", ToggleTheme, { desc = "Toggle light/dark theme" })
