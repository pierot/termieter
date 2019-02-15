###################################
# NeoVIM switch

have() {
  type "$1" &> /dev/null
}

if have nvim; then
  export EDITOR=nvim

  alias v="nvim ."
  alias vim="nvim"
  alias vi="nvim"
  alias vimdiff='nvim -d'
  alias oldvim="/usr/local/bin/vim"
fi

# neomutt
if have neomutt; then
  alias mutt="neomutt"
  alias m="neomutt"
fi

###################################

export TRMU=~/.termieter/users/jeroenb
