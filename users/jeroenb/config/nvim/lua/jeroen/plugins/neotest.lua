return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"jfpedroza/neotest-elixir",
	},
	keys = {
		{
			"<leader>tn",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run file tests",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Show test output",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle output panel",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-elixir")({
				post_process_command = function(cmd)
					local env_file = vim.fn.getcwd() .. "/.env.test"
					if vim.fn.filereadable(env_file) == 1 then
						return { "bash", "-c", "source .env.test && " .. table.concat(cmd, " ") }
					end
					return cmd
				end,
			}),
			},
		})
	end,
}
