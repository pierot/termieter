function ToggleTheme()
	if vim.o.background == "dark" then
		vim.o.background = "light"
		vim.cmd("colorscheme jellybeans-nvim")
	else
		vim.o.background = "dark"
		vim.cmd("colorscheme jellybeans-nvim")
	end
end

vim.keymap.set("n", "<F5>", ":lua ToggleTheme()<CR>") -- Switch between windows by hitting <Tab> twice
