local status, elixir = pcall(require, "elixir")
if (not status) then return end

elixir.setup({
  nextls = {enable = true},
  credo = {enable = true},
  elixirls = {enable = false},
})
