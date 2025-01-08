return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local rg_args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		}
		-- telescope.load_extension("live_grep_args")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				file_ignore_patterns = { "node_modules", "vendor", "**/*.min.js", "priv/static/js" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
			-- buffer_previewer_maker = new_maker,
			pickers = {
				find_files = {
					theme = "ivy",
					-- requires 'fd' te be installed
					find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git", "--exclude", "node_modules" },
				},
				buffers = {
					theme = "ivy",
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- telescope
		keymap.set("n", "<c-p>", "<cmd>Telescope find_files<CR>")
		keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>")
		--keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")
		keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
		keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
		keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
		keymap.set("n", "<leader>fr", ":lua require('telescope')..lsp_references()<CR>")

		-- multigrep (tnx TJ)
		keymap.set("n", "<leader>mg", require("jeroen.plugins.telescope.multigrep").live_multigrep)
	end,
}
