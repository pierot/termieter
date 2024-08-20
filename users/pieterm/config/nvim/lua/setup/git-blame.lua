local u = require("utils")

return {
	"f-person/git-blame.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitblame").setup({
			--Note how the `gitblame_` prefix is omitted in `setup`
			enabled = false,
		})

    u.map("n", "<leader>gB", ":GitBlameToggle<CR>")
	end,
}
