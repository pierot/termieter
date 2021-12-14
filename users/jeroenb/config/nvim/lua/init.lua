-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd'
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo, g = vim.g}

-------------------------------------------------
-- UTILS
-------------------------------------------------

-- https://github.com/neovim/neovim/pull/13479
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------------------------------------
-- PLUGINS
-------------------------------------------------

require 'paq' {
	'lewis6991/impatient.nvim';                      -- faster startup
	"mhartington/formatter.nvim";
	'kyazdani42/nvim-tree.lua';                      -- sidebar file explorer
	'kyazdani42/nvim-web-devicons';                  -- web dev icons used by many plugins

	'nvim-lua/popup.nvim';                           -- ui plugin used by many, someday upstream in neovim
	'nvim-lua/plenary.nvim';                         -- ui plugin used by many, someday upstream in neovim

	'blackCauldron7/surround.nvim'; 
	'tpope/vim-fugitive'; 
	'tpope/vim-repeat';
	'neovimhaskell/haskell-vim';

	'jeffkreeftmeijer/vim-numbertoggle';
	'docunext/closetag.vim';
	'mattn/emmet-vim';
	'kana/vim-textobj-user';
	'kana/vim-textobj-line';
	'andyl/vim-textobj-elixir';
	'elixir-editors/vim-elixir';                     -- correct commentstring and other percs

	'neovim/nvim-lspconfig';
	'hrsh7th/cmp-buffer';
	'hrsh7th/cmp-nvim-lsp';                          -- autocomplete
	'hrsh7th/cmp-vsnip';
	'hrsh7th/nvim-cmp';                              -- autocomplete
	'hrsh7th/vim-vsnip';                             -- snippets
	'hrsh7th/vim-vsnip-integ';                       -- snippets
	'rafamadriz/friendly-snippets';                  -- snippets
	'nvim-treesitter/nvim-treesitter';               -- treesitter, code highlighting
	'nvim-lualine/lualine.nvim';

	-- Telescope
	'nvim-telescope/telescope.nvim';
	{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'};

	'mileszs/ack.vim';
	'steelsojka/pears.nvim';                         -- Auto Pairs
	'b3nj5m1n/kommentary';                           -- Comment

	-- Themes
	'rktjmp/lush.nvim';
	'metalelf0/jellybeans-nvim';
	-- 'EdenEast/nightfox.nvim';
	'folke/tokyonight.nvim';
	'norcalli/nvim-colorizer.lua';
	--'gruvbox-community/gruvbox'
}

-------------------------------------------------
-- GENERAL SETTINGS
-------------------------------------------------


-- Basic settings
local indent = 2

opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('w', 'list', false)                               -- Hide some invisible characters (tabs...)
opt('w', 'listchars', 'tab:»·,trail:·,eol:¬,nbsp:_')
opt('g', 'ffs', 'unix,mac,dos')	                      -- Support all three, in this order

opt('w', 'number', true)                              -- Print line number
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'scrolloff', 4 )                             -- Lines of context
opt('o', 'sidescrolloff', 8)                          -- Columns of context

opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'formatoptions', 'tcqj')                     -- j: Delete comment characters when joining lines.

opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('o', 'shiftround', true)                          -- Round indent
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('w', 'wrap', true)
opt('w', 'lbr', true)                                 -- Wrap long lines at a character in 'breakat' rather than last character that fits screen

opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'autoindent', true)
opt('b', 'copyindent', true)                          -- Take indentation from previous line

opt('o', 'hlsearch', true)                            -- Highlight search things
opt('o', 'incsearch', true)                           -- Make search act like search in modern browsers
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals

opt('g', 'hidden', true)                              -- Enable switching between buffers without saving
opt('g', 'switchbuf', 'usetab')                       -- Switch to existing tab then window when switching buffer
opt('g', 'fsync', true)                               -- Sync after write
opt('g', 'confirm', true)                             -- Ask whether to save changed files
opt('g', 'lazyredraw', true)                          -- Do not redraw when executing macros
opt('w', 'cursorline', true)                          -- Highlight current line
opt('g', 'showmatch', true)                           -- Briefly jumps the cursor to the matching brace on insert

opt('o', 'completeopt', 'menu,menuone,noselect')      -- Completion options, needed for cmp
opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('o', 'wildignore', '*.o,*~,*node_modules*,.git,.yarn,*.min.*,*map') -- Ignore when tab completing
opt('o', 'wildmenu', true)
opt('o', 'wildignorecase', true)

opt('o', 'clipboard', 'unnamed,unnamedplus')

-- Buffers
opt('g', 'hidden', true)                              -- Enable switching between buffers without saving
opt('g', 'switchbuf', 'usetab')                       -- Switch to existing tab then window when switching buffer
opt('g', 'fsync', true)                               -- Sync after write
opt('g', 'confirm', true)                             -- Ask whether to save changed files

opt('o', 'mouse', 'a')

cmd 'syntax enable'
cmd 'filetype plugin indent on'


-------------------------------------------------
-- MAPPINGS
-------------------------------------------------


g.mapleader = ','

map('n', 'Q', '<Nop>')                                -- We don't do ex mode
map('', ';', ':')                                     -- Map ; to :
-- map('n', '<leader>l', ':set list!<CR>')               -- Toggle invisible characters
map('n', '<CR>', '<cmd>nohlsearch<CR>')               -- Clear the search buffer when hitting return
map('n', 'S', 'mzi<CR><ESC>`z')                       -- Split line and preserve cursor position
map('n', 'gI', '`.')                                  -- Move to the position where the last change was made

map('c', 'w!!', '<cmd>w !sudo tee % >/dev/null<CR>')  -- Write read-only file via sudo
map('n', '<leader>w', '<cmd>w<CR>')                   -- Alias to :w

-- Path copy helpers
map('n', '<leader>cf', '<cmd>let @*=expand("%")<CR>')     -- relative path  (src/foo.txt)
map('n', '<leader>cF', '<cmd>let @*=expand("%:p")<CR>')   -- absolute path  (/something/src/foo.txt)
map('n', '<leader>ct', '<cmd>let @*=expand("%:t")<CR>')   -- filename       (foo.txt)
map('n', '<leader>cd', '<cmd>let @*=expand("%:p:h")<CR>') -- directory name (/something/src)

-- Reselect last selection after indent/un-indent in visual/select modes
map('v', '<', '<gv')
map('v', '>', '>gv')
map('v', '<Tab>', '>')
map('v', '<S-Tab>', '<')

-- Mappings / Split windows
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-l>', '<c-w>l')

map('n', '<silent> <Tab><Tab>', '<C-w>w')             -- Switch between windows by hitting <Tab> twice
map('n', '<leader><Tab>', '<c-^>')                    -- Switch between last two files

map('','+', '3<c-w>>')                                -- Enlarge splits
map('', '-', '3<c-w><')

-- Mappings / HTML
map('v', '<leader><leader>b', '<S-S><strong>')
map('v', '<leader><leader>i', '<S-S><em>')

map('n', 'S', 'mzi<CR><ESC>`z')                       -- Split line and preserve cursor position

-- map('', '<leader>c', '"+y')                        -- Copy to clipboard in normal, visual, select and operator modes

cmd 'autocmd BufWritePost *.exs,*.ex silent :!source .env && mix format --check-equivalent %'
 
 
-- -------------------------------------------------
-- -- PLUGINS SETUP
-- -------------------------------------------------


-- nvim-colorizer
require'colorizer'.setup()

-- webdev icons
require('nvim-web-devicons').setup()

-- surround
require"surround".setup {mappings_style = "surround"}
 
-- colorscheme 
-- cmd 'colorscheme jellybeans-nvim'                              -- Put your favorite colorscheme here

--[[ -- nightfox theme
local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
  fox = "nordfox", -- change the colorscheme to use nordfox
})
-- Load the configuration set above and apply the colorscheme
nightfox.load() ]]
-- cmd 'colorscheme nightfox'

-- opt('g', 'tokyonight_style', 'night')  
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
cmd 'colorscheme tokyonight'         
 
-- lualine
local function getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return ""
  end
end

-- local lineNum = vim.api.nvim_win_get_cursor(0)[1]
local function getLines()
  return tostring(vim.api.nvim_win_get_cursor(0)[1]) .. "/" .. tostring(vim.api.nvim_buf_line_count(0))
end

local function getColumn()
  local val = vim.api.nvim_win_get_cursor(0)[2]
  -- pad value to 3 units to stop geometry shift
  return string.format("%03d", val)
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-- get colors from Nightfox to use in the words count
-- local colors = require("nightfox.colors").init("nordfox")
local colors = require("tokyonight.colors").setup({}) 

-- print(vim.inspect(nfColors))
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight",
    -- theme = "nightfox",
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", source = diff_source, color_added = "#a7c080", color_modified = "#ffdf1b", color_removed = "#ff6666" },
    },
    lualine_c = {
      {'diagnostics', sources = {'nvim_diagnostic'}},
      function()
        return "%="
      end,
      "filename",
      {
        getWords,
        color = { fg = colors["bg_alt"] or "#333333", bg = colors["fg"] or "#eeeeee" },
        separator = { left = "", right = "" },
      },
    },
    lualine_x = { "filetype" },
    lualine_y = {},
    lualine_z = {
      { getColumn, padding = { left = 1, right = 0 } },
      { getLines, icon = "", padding = 1 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
  },
})

-- ack
g.ackprg = 'rg --vimgrep'
 
-- nvim-tree
require'nvim-tree'.setup({
  auto_close = true,
  open_on_setup = false,
  update_to_buf_dir = { enable = true, auto_open = false },
  diagnostics = {
    enable = true
  }
})

map('n', '<c-n>', '<cmd>NvimTreeToggle<CR>')
map('n', 'R', '<cmd>NvimTreeRefresh<CR>')

-- fugitive
map('n', '<leader>gs', '<cmd>Git<CR>')
 
-- Telescope
-- Check to extend: https://github.com/varbhat/dotfiles/blob/main/dot_config/nvim/lua/utils/telescope.lua
map('n', '<c-p>', '<cmd>Telescope find_files<CR>')
map('n', '<c-b>', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fb', '<cmd>Telescope file_browser<CR>')
map('n', '<leader>gb', '<cmd>Telescope git_branches<CR>')
map('n', '<leader>gc', '<cmd>Telescope git_commits<CR>')
--map('n', '<leader>gs', '<cmd>Telescope git_status<CR>')

local previewers = require('telescope.previewers')

-- TODO: 
-- for now, telescope has serious hickups showing the coloured preview
-- it improved by disabling it for some filetypes, but I got the best results
-- disabling it alltogehter. I don't care about coloured previews.
-- Check in the future if it has improved.
-- local _bad = { '.*%.json', '.*%.lua', '.*%.ex', '*.%.eex', '.*%.exs', '.*%.leex', '' } -- Put all filetypes that slow you down in this array
-- local bad_files = function(filepath)
--   for _, v in ipairs(_bad) do
--     if filepath:match(v) then
--       return false
--     end
--   end
-- 
--   return true
-- end

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  -- opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
  opts.use_ft_detect = false
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {"node_modules/.*", "vendor/.*"},
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    buffer_previewer_maker = new_maker,
  },
  pickers = {
    find_files = {
      theme = "ivy"
    },
    buffers = {
      theme = "ivy"
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

require('telescope').setup {
  defaults = {
    buffer_previewer_maker = new_maker,
  }
}

-- Auto pairs
require('pears').setup()

-- Emmet
g.use_emmet_complete_tag = 1
g.user_emmet_leader_key = '<c-e>'
g.user_emmet_settings = "{ 'javascript.jsx' : { 'extends' : 'jsx' } }"

-- Treesitter
local ts = require('nvim-treesitter.configs')
ts.setup({
  ensure_installed = {
    "javascript", "typescript", "tsx", "jsdoc", "jsonc",
    "html", "css", "scss",
    "json", "toml", "yaml",
    "lua", "query", "dockerfile", "php",
  },
  highlight = {
    enable = true
  },
  -- highlight = {enable = {enabled = true, use_languagetree = true}},
  indent = {
    enable = true
  },
  textobjects = {
    enable = true
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
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
    end
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    -- For vsnip user.
    { name = 'vsnip' },
    { name = 'buffer' },
  }
})

-------------------------------------------------
-- LSP
-------------------------------------------------


local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<leader>lf",
                      "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<leader>lf",
                      "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
  end
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Update for cmp
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Resolvers
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Code actions
capabilities.textDocument.codeAction = {
  dynamicRegistration = true,
  codeActionLiteralSupport = {
      codeActionKind = {
          valueSet = (function()
              local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
              table.sort(res)
              return res
          end)()
      }
  }
}

-- Snippets
capabilities.textDocument.completion.completionItem.snippetSupport = true;

-- Elixir
local path_to_elixirls = vim.fn.expand("/home/jeroen/.local/share/elixir-ls/release/language_server.sh")

-- Setup
nvim_lsp.elixirls.setup({
  on_attach = on_attach, 
  capabilities = capabilities,
  cmd = { path_to_elixirls },
  settings = {
    elixirLS = {
      fetchDeps = false,
      dialyzerFormat = "dialyxir_long",
      dialyzerWarnOpts = {"error_handling", "no_behaviours", "no_contracts", "no_fail_call", "no_fun_app", "no_improper_lists", "no_match", "no_missing_calls", "no_opaque", "no_return", "no_undefined_callbacks", "no_unused", "underspecs", "unknown", "unmatched_returns", "overspecs"},
      dialyzerEnabled = true,
      suggestSpecs = true
    }
  }
})

nvim_lsp.tsserver.setup({ 
  on_attach = on_attach, 
  capabilities = capabilities
})

-- LSP Prevents inline buffer annotations
vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_on_insert = false,
})

local signs = {
  Error = "ﰸ",
  Warn = "",
  Hint = "",
  Info = "",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
end

vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focusable=false, source = 'always'})]])

-- Prettier function for formatter
local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "" },
    stdin = true,
  }
end
 
require("formatter").setup({
  logging = false,
  filetype = {
    javascript = { prettier },
    typescript = { prettier },
    typescriptreact = { prettier },
    html = { prettier },
    css = { prettier },
    scss = { prettier },
    markdown = { prettier }
  },
})
 
-- Runs Formatter on save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.tsx,*.css,*.scss,*.md,*.html : FormatWrite
augroup END
]],
  true
)
