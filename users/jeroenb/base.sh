# This file is still here in case I hop over to OSX
# On Arch, my zsh in in ~/.config/zsh

have() {
  type "$1" &> /dev/null
}

function cd {
  builtin cd "$@" && ls -lF
}

function sloc {
  git ls-files | egrep '\.erl|\.exs?|\.tsx?$' | xargs cat | sed '/^$/d' | sed '/^\s*#/d' | wc -l
}

function sloc_elixir {
  git ls-files | egrep '\.erl|\.exs?$' | xargs cat | sed '/^$/d' | sed '/^\s*#/d' | wc -l
}

function sloc_js {
  git ls-files | egrep '\.jsx?$' | xargs cat | sed '/^$/d' | sed '/^\s*#/d' | wc -l
}

function sloc_ts {
  git ls-files | egrep '\.tsx?$' | xargs cat | sed '/^$/d' | sed '/^\s*#/d' | wc -l
}

# neomutt
if have neomutt; then
  alias mutt="neomutt"
  alias m="neomutt"
fi

if have bat; then
  alias cat="bat"
fi

# Neovim/Vim
if have nvim; then
  alias vimd="cd ~/.config/nvim"
  alias vime="vim ~/.config/nvim/lua/init.lua"
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

# python 3.8
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/python@3.8/lib"

# my bin
export PATH="$TRMU/bin:$PATH"

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Rupa z
. $HOME/.termieter/users/jeroenb/bin/z.sh

# Local bin
export PATH="/usr/local/opt/php@7.3/bin:$HOME/.local/bin:$PATH"
