local status, gitsigns = pcall(require, "gitsigns")
if not status then
  return
end

gitsigns.setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 600,
    ignore_whitespace = true,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author> · <author_time:%Y-%m-%d %H:%M:%S> · <summary>',
})
