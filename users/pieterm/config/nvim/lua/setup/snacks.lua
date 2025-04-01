local status, snacks = pcall(require, "snacks")
if (not status) then return end

snacks.setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})
