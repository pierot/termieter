" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" order matters
lua require('init')
lua require('plugins')
lua require('setup')

lua print("Jack + Joe rocks!")
