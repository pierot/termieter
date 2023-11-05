return {
  "elixir-tools/elixir-tools.nvim", 
  dependencies = { "nvim-lua/plenary.nvim"  },
  event = { 
    "BufEnter *.ex,*.exs.*.eex,*.heex,*.leex",
    "BufRead *.ex,*.exs.*.eex,*.heex,*.leex"
  },
  config = function()
    require("elixir").setup({
      nextls = {enable = true},
      credo = {enable = true},
      elixirls = {enable = false},
    })
  end
}
