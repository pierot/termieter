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
lua require('setup.lsp')
lua require('setup.nvimtree')
lua require('setup.emmet')
lua require('setup.lualine')
lua require('setup.vim-test')
lua require('setup.telescope')
lua require('setup.treesitter')
lua require('setup.snippets')
lua require('setup.formatter')
