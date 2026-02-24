return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
				map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage hunk" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset hunk" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
				map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
				map("n", "<leader>gb", gs.blame_line, { desc = "Blame line" })
				map("n", "<leader>gB", gs.blame_line, { desc = "Blame" })
			end,
		})
	end,
}
