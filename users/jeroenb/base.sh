###################################
# NeoVIM switch

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

if have nvim; then
  export EDITOR=nvim

  alias v="nvim"
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
alias kl="kitty-tmux @ set_color ~/.config/kitty/themes/ayu_light.conf"
alias kd="kitty-tmux @ set_color ~/.config/kitty/themes/default.conf"
alias ssh="kitty +kitten ssh"

# python 3.8
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/python@3.8/lib"

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"
