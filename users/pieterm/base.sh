###################################
# NeoVIM switch

if have nvim; then
  export EDITOR=nvim

  alias v="nvim ."
  alias vim="nvim"
  alias vi="nvim"
  alias vimdiff='nvim -d'

  alias oldvim="/usr/local/bin/vim"
fi

###################################

if [ -d $DROPBOX ]; then
  alias repos="cd $DROPBOX/Work/repos/"
  alias dev="cd $DROPBOX/Work/devel/"
fi

export PATH="/usr/local/opt/php@7.3/bin:$PATH"
