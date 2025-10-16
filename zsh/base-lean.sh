#!/usr/bin/env zsh
# Lean ZSH configuration - replaces oh-my-zsh with standalone plugins
# Performance-optimized for fast startup

have() {
  type "$1" &> /dev/null
}

###############################################################################
# THEME & COLORS
###############################################################################

# Set theme based on system
ZSH_THEME="kolo"

# Debian servers
if [ -n "$(uname -a | grep Debian)" ]; then
  ZSH_THEME="dallas"
fi

# RPI (armv6l, armv7l)
if [ -n "$(uname -a | grep armv6l)" ] || [ -n "$(uname -a | grep armv7l)" ]; then
  ZSH_THEME="alanpeabody"
fi

# RPI or ARM (aarch64)
if [ -n "$(uname -a | grep aarch64)" ]; then
  if [ -n "$(cat /proc/device-tree/model 2>/dev/null | grep -a "Raspberry")" ]; then
    ZSH_THEME="alanpeabody"
  fi
fi

# Colors for ls and autocompletion
if have dircolors; then
  eval $( dircolors -b $TRM/zsh/LS_COLORS )
fi

###############################################################################
# COMPLETION SYSTEM - OPTIMIZED
###############################################################################

# Enable completion system
autoload -Uz compinit

# Only regenerate compdump once per day (performance optimization)
# This gives ~50-100ms speedup on subsequent shell loads
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Add external completion paths
fpath=(/usr/local/share/zsh-completions $fpath)

# Completion styling
zstyle ':completion:*' menu yes=long select
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

###############################################################################
# HISTORY SETTINGS
###############################################################################

# When listing options (by `setopt', `unsetopt', `set -o' or `set +o'),
# those turned on by default appear in the list prefixed with `no'.
setopt notify                  # Report status of background jobs immediately
setopt extendedhistory        # Save timestamp in history
setopt inc_append_history     # Appends every command to history once executed
setopt share_history          # Reloads history whenever you use it
setopt histreduceblanks       # Remove superfluous blanks from commands
setopt histignorespace        # Don't save commands starting with space
setopt histignorealldups      # Don't save duplicates

###############################################################################
# OTHER OPTIONS
###############################################################################

# Disable auto title
DISABLE_AUTO_TITLE="true"

# Show dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Autosuggest optimization (if plugin is installed)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

###############################################################################
# LOAD PLUGINS
###############################################################################

# Check if starship is available - use it instead of theme if present
if have starship; then
  eval "$(starship init zsh)"
else
  # Load minimal plugins when not using starship

  # History substring search (universal)
  [[ -f "$TRM/zsh/plugins/history-substring-search.zsh" ]] && \
    source "$TRM/zsh/plugins/history-substring-search.zsh"

  # Colored man pages (universal)
  [[ -f "$TRM/zsh/plugins/colored-man-pages.zsh" ]] && \
    source "$TRM/zsh/plugins/colored-man-pages.zsh"

  # Platform-specific plugins
  if [[ $OS == 'OSX' ]]; then
    # fzf integration handled in common.sh
    [[ -f "$TRM/zsh/plugins/mix-fast.zsh" ]] && source "$TRM/zsh/plugins/mix-fast.zsh"
    [[ -f "$TRM/zsh/plugins/git.zsh" ]] && source "$TRM/zsh/plugins/git.zsh"
    [[ -f "$TRM/zsh/plugins/asdf.zsh" ]] && source "$TRM/zsh/plugins/asdf.zsh"
  fi

  # Debian-specific: minimal, no extra plugins needed
fi

###############################################################################
# KEY BINDINGS
###############################################################################

bindkey -e  # Use emacs keybindings

###############################################################################
# LOAD USER CUSTOMIZATIONS
###############################################################################

# Load base shell configuration
[ -f $TRM/zsh/base.sh ] && source $TRM/zsh/base.sh

# Load user-specific local config
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

###############################################################################
# ALIASES
###############################################################################

alias reload!='exec zsh'
