-- Official utility wrapper around the builtin LSP config
-- https://github.com/neovim/nvim-lspconfig
-- To overwrite the default configs supplied by the package, simply
-- copy them to the local lsp folder.
return {
	"neovim/nvim-lspconfig",
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- { "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Completion capabilities — prefer blink.cmp, fall back to nvim-cmp,
		-- so switching completion engines doesn't break LSP capabilities.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok_blink, blink = pcall(require, "blink.cmp")
		if ok_blink then
			capabilities = blink.get_lsp_capabilities(capabilities)
		else
			local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if ok_cmp then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end
		end

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Small manual override for emmet_ls to add .heex support
		vim.lsp.config.emmet_ls = {
			filetypes = { "heex" },
			-- filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "heex" },
		}

		vim.lsp.config.tailwindcss = {
			-- Pin to mason binary: PATH lookup hits the asdf shim, which fails on
			-- node versions without the package installed.
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/tailwindcss-language-server", "--stdio" },
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

				-- Show LSP document colors (e.g. tailwind classes) as a virtual
				-- swatch next to the text instead of painting the background
				vim.lsp.document_color.enable(true, { bufnr = args.buf }, { style = "virtual" })
			end,
		})

		vim.lsp.enable({
			"html",
			"emmet_ls",
			"cssls",
			"tailwindcss",
			"ts_ls",
			"lua_ls",
			"expert",
		})
	end,
}
