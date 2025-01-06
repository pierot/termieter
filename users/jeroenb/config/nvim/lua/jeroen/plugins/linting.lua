return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"rcarriga/nvim-notify",
	},
	-- lazy = true,
	-- event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local notify = require("notify")
		local nvimlint = require("lint")

		nvimlint.linters_by_ft = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			json = { "jsonlint" },
			jsonc = { "jsonlint" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				nvimlint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>leu", function()
			notify.notify("ESLint enabled", "info", { title = "Linters" })
			nvimlint.linters_by_ft.javascript = { "eslint_d" }
			nvimlint.linters_by_ft.javascriptreact = { "eslint_d" }
			nvimlint.linters_by_ft.typescript = { "eslint_d" }
			nvimlint.linters_by_ft.typescriptreact = { "eslint_d" }
		end, { desc = "Enable ESLint" })

		vim.keymap.set("n", "<leader>led", function()
			notify.notify("ESLint disabled", "warn", { title = "Linters" })
			nvimlint.linters_by_ft.javascript = {}
			nvimlint.linters_by_ft.javascriptreact = {}
			nvimlint.linters_by_ft.typescript = {}
			nvimlint.linters_by_ft.typescriptreact = {}
		end, { desc = "Disable ESLint" })

		-- Restart eslint_d
		local restartEsLintD = function()
			vim.cmd("silent !eslint_d restart")
			notify.notify("Restarted ESLint", "info", { title = "Linters" })
		end

		local restartFlatConfigEsLintD = function()
			vim.cmd("silent !env ESLINT_USE_FLAT_CONFIG=true eslint_d restart")
			notify.notify("Restarted ESLint with flat config", "info", { title = "Linters" })
		end

		vim.keymap.set("n", "<leader>re", restartEsLintD, { desc = "Restart ESLint_D" })
		vim.keymap.set("n", "<leader>rf", restartFlatConfigEsLintD, { desc = "Restart ESLint_D with flat config" })

		-- local lint = require("lint")
		--
		-- lint.linters_by_ft = {
		-- 	javascript = { "eslint_d" },
		-- 	typescript = { "eslint_d" },
		-- 	javascriptreact = { "eslint_d" },
		-- 	typescriptreact = { "eslint_d" },
		-- }
		--
		-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		--
		-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		-- 	group = lint_augroup,
		-- 	callback = function()
		-- 		lint.try_lint()
		-- 	end,
		-- })
		--
		-- vim.keymap.set("n", "<leader>l", function()
		-- 	lint.try_lint()
		-- end, { desc = "Trigger linting for current file" })
		--
		-- -- set env var for eslint_d
		-- local eslint_d = lint.linters.eslint_d
		-- eslint_d.env = { ["ESLINT_USE_FLAT_CONFIG"] = "true" }
		--
		-- eslint_d.condition = function(self, ctx)
		-- 	return vim.fs.find({ "eslint.config.js", ".eslintrc.cjs" }, { path = ctx.filename, upward = true })[1]
		-- end
		--
		-- local lint_progress = function()
		-- 	local linters = require("lint").get_running()
		-- 	if #linters == 0 then
		-- 		return "󰦕"
		-- 	end
		-- 	return "󱉶 " .. table.concat(linters, ", ")
		-- end
	end,
}
