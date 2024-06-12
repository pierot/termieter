return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	config = function()
		vim.api.nvim_create_autocmd({ "BufReadPost" }, {
			pattern = { "*.dbout" },
			callback = function()
				vim.api.nvim_exec2(
					[[
          exe ':resize 40'
          ]],
					{}
				)
			end,
		})
		-- vim.cmd([[
		--       let g:completion_chain_complete_list = {
		--           \   'sql': [
		--           \    {'complete_items': ['vim-dadbod-completion']},
		--           \   ],
		--           \ }
		--       " Make sure `substring` is part of this list. Other items are optional for this completion source
		--       let g:completion_matching_strategy_list = ['exact', 'substring']
		--       " Useful if there's a lot of camel case items
		--       let g:completion_matching_ignore_case = 1
		--     ]])
	end,
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
	end,
}
