local u = require("utils")

--[[ require("tokyonight").setup({
	light_style = "day",
	terminal_colors = true,
	transparent = true,
	transparent_sidebar = true,
	italic_functions = true,
	dark_float = true,
	lualine_bold = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
	day_brightness = 0.3,
	on_highlights = function(hl, c)
		hl.Normal = {
			bg = "#1a1a1a",
			fg = "#fafafa",
		}
	end,
}) ]]

vim.o.termguicolors = true
-- vim.cmd("colorscheme tokyonight-night")
vim.cmd("colorscheme onedark_dark")
vim.o.background = "dark"

function ToggleTheme()
	if vim.o.background == "dark" then
		vim.cmd("colorscheme tokyonight-day")
		vim.o.background = "light"
	else
		vim.cmd("colorscheme onedark_dark")
		vim.o.background = "dark"
	end
end

u.map("n", "<F5>", ":lua ToggleTheme()<CR>")
