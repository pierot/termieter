-- Vim-vsnip
vim.g.vsnip_filetypes = {
  javascriptreact = {"javascript"},
  typescript = {"javascript"},
  typescriptreact = {"javascript"},
  elixir = {"elixir"},
  eelixir = {"eelixir"}
}

-- Cmp + vim-vsnip
local cmp = require("cmp")
cmp.setup({
  completion = {
    -- autocomplete = false,
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

--[[ vim.api.nvim_create_autocmd(
  {"TextChangedI", "TextChangedP"},
  {
    callback = function()
      local line = vim.api.nvim_get_current_line()
      local cursor = vim.api.nvim_win_get_cursor(0)[2]

      local current = string.sub(line, cursor, cursor + 1)
      if current == "." or current == "," or current == " " then
        require('cmp').close()
      end

      local before_line = string.sub(line, 1, cursor + 1)
      local after_line = string.sub(line, cursor + 1, -1)
      if not string.match(before_line, '^%s+$') then
        if after_line == "" or string.match(before_line, " $") or string.match(before_line, "%.$") then
          require('cmp').complete()
        end
      end
  end,
  pattern = "*"
}) ]]
