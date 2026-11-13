-- nightfox ignores 'background', so switch the colorscheme itself:
-- nightfox (dark) <-> dayfox (light).
function ToggleTheme()
	if vim.o.background == "dark" then
		vim.cmd("colorscheme dayfox")
	else
		vim.cmd("colorscheme nightfox")
	end
end

vim.keymap.set("n", "<F5>", ToggleTheme, { desc = "Toggle light/dark theme" })
