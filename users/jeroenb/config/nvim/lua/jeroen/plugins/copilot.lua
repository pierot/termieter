return {
	"github/copilot.vim",
	config = function()
		local opts = { expr = true, replace_keycodes = false }
		vim.keymap.set("i", "<C-C>", 'copilot#Accept("\\<CR>")', opts)
		vim.keymap.set("i", "<C-O>", 'copilot#Accept("\\<CR>")', opts)
		vim.keymap.set("i", "<C-T>", 'copilot#Accept("\\<CR>")', opts)
		vim.g.copilot_no_tab_map = true
	end,
}
