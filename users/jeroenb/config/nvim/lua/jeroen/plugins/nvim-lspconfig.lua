-- Official utility wrapper around the builtin LSP config
-- https://github.com/neovim/nvim-lspconfig
-- To overwrite the default configs supplied by the package, simply
-- copy them to the local lsp folder.
return {
	"neovim/nvim-lspconfig",
	-- enabled = false,
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		-- { "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- vim.lsp.config("*", {
		-- 	root_markers = { ".git" },
		-- })

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Small manual override for emmet_ls to add .heex support
		vim.lsp.config.emmet_ls = {
			filetypes = { "heex" },
			-- filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "heex" },
		}

		-- Configure tailwindcss to use project-local or global installation
		-- This tries: 1) project node_modules, 2) pnpm global, 3) asdf shim
		local function get_tailwind_cmd()
			local project_bin = vim.fn.getcwd() .. "/node_modules/.bin/tailwindcss-language-server"
			local pnpm_bin = vim.fn.expand("~/.config/local/share/pnpm/tailwindcss-language-server")
			local asdf_bin = vim.fn.expand("~/.asdf/shims/tailwindcss-language-server")

			if vim.fn.executable(project_bin) == 1 then
				return { project_bin, "--stdio" }
			elseif vim.fn.executable(pnpm_bin) == 1 then
				return { pnpm_bin, "--stdio" }
			elseif vim.fn.executable(asdf_bin) == 1 then
				return { asdf_bin, "--stdio" }
			else
				-- Fallback to command in PATH
				return { "tailwindcss-language-server", "--stdio" }
			end
		end

		vim.lsp.config.tailwindcss = {
			cmd = get_tailwind_cmd(),
			capabilities = capabilities,
		}

		-- LSP keymaps (set when LSP attaches to buffer)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local opts = { buffer = args.buf, silent = true }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "Go to declaration" })
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "Show references" })
				vim.keymap.set(
					"n",
					"gi",
					vim.lsp.buf.implementation,
					{ buffer = args.buf, desc = "Go to implementation" }
				)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover documentation" })
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename symbol" })
				vim.keymap.set(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ buffer = args.buf, desc = "Code action" }
				)
				vim.keymap.set(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					{ buffer = args.buf, desc = "Line diagnostics" }
				)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = args.buf, desc = "Previous diagnostic" })
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = args.buf, desc = "Next diagnostic" })
			end,

			vim.lsp.enable({ "html", "emmet_ls", "cssls", "tailwindcss", "ts_ls", "lua_ls", "expert" }),
		})
	end,
}
