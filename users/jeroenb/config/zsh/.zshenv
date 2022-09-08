#!/bin/zsh
source $HOME/.termieter/env

# Env variables
export BROWSER="firefox"
export WEECHAT_HOME=$HOME/.config/weechat
export DROPBOX=$HOME/Dropbox
export IAMJACK="$HOME/Dropbox/iamjack"
export XDG_CONFIG_HOME="$HOME/.config"
export TERMINAL="kitty"
export ZDOTDIR=$HOME/.config/zsh
export EDITOR="nvim"
export FILE="nnn"
export TRMU="$HOME/.termieter/users/jeroenb"
export FLYCTL_INSTALL="/home/jeroen/.fly"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export NOTMUCH_CONFIG=$HOME/.config/notmuch/notmuch-config

# PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$FLYCTL_INSTALL/.bin" ] ;
  then PATH="$FLYCTL_INSTALL/.bin:$PATH"
fi

if [ -d "$TRMU/bin" ] ;
  then PATH="$TRMU/bin:$PATH"
fi

if [ -d "$TRMU/bin/statusbar" ] ;
  then PATH="$TRMU/bin/statusbar:$PATH"
fi

if [ -d "$HOME/go" ] ;
  then PATH="$HOME/go/bin:$PATH"
fi

export PATH="$PATH:$HOME/go/bin"

# fly
export FLYCTL_INSTALL="/home/jeroen/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

. $TRMU/bin/z.sh
