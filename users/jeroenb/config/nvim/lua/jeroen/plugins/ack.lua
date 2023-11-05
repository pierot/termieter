return {
	"mileszs/ack.vim",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>a", ":Ack<space>")
	end,
}
