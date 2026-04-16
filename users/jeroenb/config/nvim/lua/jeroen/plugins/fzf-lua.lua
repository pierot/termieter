return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")

		fzf.setup({
			"default",
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<c-p>", fzf.files, { desc = "Find files" })
		keymap.set("n", "<leader>b", fzf.buffers, { desc = "Buffers" })
		keymap.set("n", "<leader>fc", fzf.grep_cword, { desc = "Grep word under cursor" })
		keymap.set("n", "<leader>gc", fzf.git_commits, { desc = "Git commits" })
		keymap.set("n", "<leader>fg", function()
			fzf.live_grep({
				rg_opts = [[--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --glob '!test/**' -e]],
			})
		end, { desc = "Live grep (exclude test)" })
		keymap.set("n", "<leader>ft", fzf.live_grep, { desc = "Live grep" })
		keymap.set("n", "<leader>fr", fzf.lsp_references, { desc = "LSP references" })
	end,
}
