--[[ local setup, ts = pcall(require, 'nvim-treesitter.configs')
if (not setup) then return end

ts.setup({
  ensure_installed = {
    "javascript", "typescript", "tsx", "jsdoc", "jsonc",
    "html", "css", "scss", "json", "toml", "yaml",
    "lua", "query", "dockerfile", "php", 
    "haskell", "c", "bash",
    "elixir", "heex",
  },
  sync_install = false,
  ignore_install = { },
  highlight = {
    enable = true,
    disable = function(lang, bufnr) -- Disable in large C++ buffers
      return lang == "sql" and vim.api.nvim_buf_line_count(bufnr) > 1000
    end,
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
  autotag = {enable = true},
  auto_install = true
}) ]]

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
          disable = function(lang, bufnr) -- Disable in large C++ buffers
            return lang == "sql" and vim.api.nvim_buf_line_count(bufnr) > 1000
          end,
        },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
        },
        -- ensure these language parsers are installed
        ensure_installed = {
          "bash",
          "c", 
          "css",
          "dockerfile",
          "elixir", 
          "gitignore",
          "haskell", 
          "heex",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "php", 
          "query",
          "query",
          "scss", "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
}