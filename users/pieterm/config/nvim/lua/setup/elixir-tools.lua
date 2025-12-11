-- Elixir tools setup (ExpertLS language server)
local elixir_ok, elixir = pcall(require, "elixir")
if not elixir_ok then
	return
end

elixir.setup({
	nextls = { enable = false }, -- NextLS disabled, using ExpertLS instead
	credo = {}, -- Credo linter enabled with defaults
	elixirls = { enable = false }, -- Old ElixirLS disabled, using ExpertLS instead
})
