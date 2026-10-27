return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.nvim" },
	cmd = "FzfLua",
	keys = {
		{ "<c-p>", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{ "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
		{ "<leader>fc", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
		{ "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep({
					rg_opts = [[--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --glob '!test/**' -e]],
				})
			end,
			desc = "Live grep (exclude test)",
		},
		{ "<leader>ft", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
		{ "<leader>fr", "<cmd>FzfLua lsp_references<cr>", desc = "LSP references" },
		{ "<leader>fs", "<cmd>FzfLua colorschemes<cr>", desc = "Find colorscheme" },
	},
	config = function()
		require("fzf-lua").setup({
			"default",
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		})
	end,
}
