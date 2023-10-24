return {
  "elixir-tools/elixir-tools.nvim", 
  dependencies = { "nvim-lua/plenary.nvim"  },
  config = function()
    require("elixir").setup({
      nextls = {enable = true},
      credo = {enable = true},
      elixirls = {enable = false},
    })
  end
}
