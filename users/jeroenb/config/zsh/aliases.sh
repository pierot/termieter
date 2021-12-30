#!/bin/zsh

# neomutt
if have neomutt; then
  alias mutt="neomutt"
  alias m="neomutt"
fi

if have bat; then
  alias cat="bat"
fi

alias dev="cd $HOME/Work/"
alias dropbox="cd $DROPBOX"
alias db="cd $DROPBOX"
alias invoicing="cd $IAMJACK/Income"
alias iamjack="cd $IAMJACK"
alias jj="cd $HOME/Work/jackjoe"
alias gj="cd $HOME/Work/jackjoe"
alias gd="cd $HOME/Downloads"
alias gD="cd $HOME/Desktop"
alias gdb="cd $DROPBOX"
alias ssh="kitty +kitten ssh"
alias df="df -h"
alias free="free -m"
alias pbcopy='xclip -selection clipboard'
alias jctl="journalctl -p 3 -xb"               # get error messages from journalctl
