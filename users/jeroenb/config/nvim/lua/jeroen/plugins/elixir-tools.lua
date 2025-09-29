return {
	"elixir-tools/elixir-tools.nvim",
	enabled = "true",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local elixir = require("elixir")
		-- Switching to ExpertLS
		-- local elixirls = require("elixir.elixirls")

		elixir.setup({
			nextls = { enable = false },
			credo = {},
			elixirls = {
				enable = false,
				-- settings = elixirls.settings({
				-- 	dialyzerEnabled = false,
				-- 	enableTestLenses = false,
				-- }),
				-- on_attach = function(client, bufnr)
				-- 	vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
				-- 	vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
				-- 	vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
				-- 	vim.keymap.set(
				-- 		"n",
				-- 		"gD",
				-- 		"<cmd>lua vim.lsp.buf.declaration()<CR>",
				-- 		{ noremap = true, silent = true }
				-- 	)
				-- 	vim.keymap.set(
				-- 		"n",
				-- 		"gd",
				-- 		"<cmd>lua vim.lsp.buf.definition()<CR>",
				-- 		{ noremap = true, silent = true }
				-- 	)
				-- end,
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
