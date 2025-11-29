#!/bin/zsh
source $HOME/.termieter/env

# Env variables
export BROWSER="firefox"
export WEECHAT_HOME=$HOME/.config/weechat
export DROPBOX=$HOME/Dropbox
export IAMJACK="$HOME/Dropbox/iamjack"
export XDG_CONFIG_HOME="$HOME/.config"
export TERMINAL="alacritty"
export ZDOTDIR=$HOME/.config/zsh
export EDITOR="/usr/bin/nvim -u $HOME/.config/nvim/init.lua"
export VISUAL="/usr/bin/nvim -u $HOME/.config/nvim/init.lua"
export FILE="thunar"
export TRMU="$HOME/.termieter/users/jeroenb"
export FLYCTL_INSTALL="/home/jeroen/.fly"
export PAGER="most"
export NOTMUCH_CONFIG=$HOME/.config/notmuch/notmuch-config
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
# export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache
export LYNX_LSS=$XDG_CONFIG_HOME/lynx/lynx.lss
export ERL_AFLAGS="-kernel shell_history enabled"
export ASDF_SKIP_COMMANDS="claude"
# export LESS='-R --use-color -Dd+r$Du+b$'
# Let all of java know we use a wm
export _JAVA_AWT_WM_NONREPARENTING=1
export SHELL=/usr/bin/zsh
export CONTAINER_HOST=unix:///run/user/$(id -u)/podman/podman.sock
# Need to install with pacman -S intellij-idea-ultimate-edition

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

if [ -d "$HOME/.bun" ] ; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

export PATH="$PATH:$HOME/go/bin"

# fly
export FLYCTL_INSTALL="/home/jeroen/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

. $TRMU/bin/z.sh

# pnpm
export PNPM_HOME="$HOME/.config/local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# asdf
if [ -f "${HOME}/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
fi 

# rust
if [ -f "${HOME}/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi 

# glab
if [ -f "${HOME}/.config/op/plugins.sh" ]; then
  . "$HOME/.config/op/plugins.sh"
fi
  
# snap
if [ -d "/var/lib/snapd/snap/bin" ]; then
  PATH="/var/lib/snapd/snap/bin:$PATH"
fi 

# Jetbrains JRE for Datagrip
if [ -d "/opt/intellij-idea-ultimate-edition/jbr" ]; then
  export DATAGRIP_JDK=/opt/intellij-idea-ultimate-edition/jbr
fi 

# my own python venv
if [ -d "${HOME}/.config/local/share/../bin" ]; then
  # uv
  export PATH="$HOME/.config/local/share/../bin:$PATH"
fi

if [ -d "${HOME}/python/bin" ]; then
  # uv
  export PATH="$HOME/python/bin:$PATH"
fi

# Atuin - only add to PATH here, init in .zshrc
if [ -d "${HOME}/.atuin/bin" ]; then
  . "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
fi
