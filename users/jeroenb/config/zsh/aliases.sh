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
alias db="cd $DROPBOX"
alias invoicing="cd $IAMJACK/Income"
alias iamjack="cd $IAMJACK"
alias jj="cd $HOME/Work/jackjoe"
alias gjj="cd $HOME/Work/jackjoe"
alias gj="cd $HOME/Work/jackjoe/justified"
alias gd="cd $HOME/Downloads"
alias gD="cd $HOME/Desktop"
alias gt="cd $HOME/.termieter"
alias gc="cd $HOME/.config"
alias gtu="cd $HOME/.termieter/users/jeroenb"
alias gdb="cd $DROPBOX"
alias ssh="kitty +kitten ssh"
alias df="df -h"
alias free="free -m"
alias pbcopy='xclip -selection clipboard'
alias jctl="journalctl -p 3 -xb"               # get error messages from journalctl
alias m='neomutt'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias xmonadconf="vim ~/.config/xmonad/xmonad.hs"
alias ssh='TERM="xterm-256color" kitty +kitten ssh'

# Git stuff
alias gap='git add -p'
alias gst='git status'
alias ga="git add $1"

alias gdoc='git add . && gcmm docs: add documentation'
alias gmerge='git add . && gcmm chore: merge'
alias gcompile='git add . && gcmm chore: compile'
alias gbump='git add . && gcmm chore: bump versions'
alias gcleanup='git add . && gcmm chore: cleanup'
alias gfix='git add . && gcmm fix'
alias gammend='git commit --amend --no-edit'
