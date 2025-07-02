local status, prettier = pcall(require, "prettier")
if not status then
	return
end

prettier.setup({
	bin = "prettierd",
	cli_options = {
		-- https://prettier.io/docs/en/cli.html#--config-precedence
		config_precedence = "prefer-file", -- or "cli-override" or "file-override"
	},
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"elixir",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
})
