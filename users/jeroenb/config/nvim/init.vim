" vim old school init
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" nvim lua init
lua print("Jack + Joe rocks!")
lua require('impatient')
" order matters
lua require('init')
lua require('plugins')
lua require('setup.autopairs')
lua require('setup.colorizer')
lua require('setup.colors')
lua require('setup.emmet')
lua require('setup.lspconfig')
lua require('setup.lspsaga')
lua require('setup.lspkind')
lua require('setup.lualine')
lua require('setup.mason')
lua require('setup.null-ls')
lua require('setup.nvimtree')
lua require('setup.prettier')
lua require('setup.snippets')
lua require('setup.telescope')
lua require('setup.treesitter')
lua require('setup.ts-autotag')
lua require('setup.vim-easy-align')
lua require('setup.web-devicons')
