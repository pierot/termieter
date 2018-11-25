###################################
# NeoVIM switch

export EDITOR=nvim

alias v="nvim ."
alias vim="nvim"
alias vi="nvim"
alias vimdiff='nvim -d'
alias oldvim="/usr/local/bin/vim"

###################################

# neomutt
alias mutt="neomutt"
alias m="neomutt"

###################################

# OSX Defaults
H=$(date +%H)
if [[ $OS == 'OSX' ]]; then
  if [[ $H == 8 ]]; then
    # Keyrepeat
    defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
  fi
fi

###################################

export TRMU=~/.termieter/users/jeroenb
