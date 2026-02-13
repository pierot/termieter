return {
	"tpope/vim-fugitive",
	enabled = false,
	config = function()
		vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
	end,
}
