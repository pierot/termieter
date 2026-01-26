return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-y>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-Right>",
			},
			ignore_filetypes = { cpp = true },
			color = {
				suggestion_color = "#585858",
				cterm = 244,
			},
			log_level = "info",
			disable_inline_completion = false, -- set to true for manual-only
			disable_keymaps = false,
		})
	end,
}
