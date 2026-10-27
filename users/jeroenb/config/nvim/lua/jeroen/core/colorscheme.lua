local M = {}

local state_file = vim.fn.stdpath("state") .. "/colorscheme"
local fallback = "carbonfox"

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

-- Remember every colorscheme change (picker, F5, :colorscheme) for the next start.
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function(event)
		vim.fn.writefile({ event.match }, state_file)
	end,
})

-- Apply the remembered colorscheme, or carbonfox when it is missing or unknown.
function M.restore()
	local ok, lines = pcall(vim.fn.readfile, state_file)
	local name = ok and lines[1] or fallback
	if not pcall(vim.cmd.colorscheme, name) then
		vim.cmd.colorscheme(fallback)
	end
end

return M
