" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" init
"lua require('impatient')
" order matters
lua require('init')
lua require('plugins')

lua require('setup.autopairs')
lua require('setup.colors')
lua require('setup.colorizer')
lua require('setup.emmet')
lua require('setup.git-blame')
lua require('setup.lspconfig')
lua require('setup.lspkind')
" lua require('setup.lspsaga')
lua require('setup.lualine')
lua require('setup.mason')
lua require('setup.none-ls')
lua require('setup.nvimtree')
lua require('setup.nvim-cmp')
lua require('setup.prettier')
lua require('setup.snippets')
lua require('setup.telescope')
lua require('setup.treesitter')
lua require('setup.ts-autotag')
lua require('setup.vim-easy-align')
lua require('setup.web-devicons')
lua require('setup.codecompanion')

lua print("Jack + Joe rocks!")
