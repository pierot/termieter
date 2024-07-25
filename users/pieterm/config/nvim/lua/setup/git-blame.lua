return {
	"f-person/git-blame.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitblame").setup({
			--Note how the `gitblame_` prefix is omitted in `setup`
			enabled = false,
		})

		vim.keymap.set("n", "<leader>gB", "<cmd>GitBlameToggle<CR>")
	end,
}

