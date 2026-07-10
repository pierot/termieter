return {
	"mileszs/ack.vim",
	event = "VeryLazy",
	init = function()
		vim.g.ackprg = "rg --vimgrep --smart-case"
	end,
	config = function()
		vim.keymap.set("n", "<leader>a", ":Ack<space>")
	end,
}
