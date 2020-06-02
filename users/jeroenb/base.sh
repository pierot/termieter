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

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# /bin/bash $TRMU/bin/macos.sh
