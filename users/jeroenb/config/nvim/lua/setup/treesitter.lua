local ts = require('nvim-treesitter.configs')
ts.setup({
  ensure_installed = "maintained",
  sync_install = false,
  ignore_install = { },
  highlight = {
    enable = true,
    diable = { }
  },
  -- highlight = {enable = {enabled = true, use_languagetree = true}},
  indent = {
    enable = true
  },
  textobjects = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000 -- Do not enable for files with more than 1000 lines, int
  },
  refactor = {
    highlight_definitions = {enable = true},
    highlight_current_scope = {enable = true},
    smart_rename = {
      enable = true,
      keymaps = {smart_rename = "grr"},
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>"
        }
      }
    }
  },
  autotag = {enable = true}
})
