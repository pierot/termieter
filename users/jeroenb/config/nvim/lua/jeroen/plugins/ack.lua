return {
	'mileszs/ack.vim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.keymap.set('n', '<leader>a', ':Ack<space>')
  end,
}
