# Environment Variables

# source $HOME/.termieter/env

function have
  type "$1" &> /dev/null
end

# Editor settings
set -x EDITOR nvim
set -x VISUAL nvim

# Node.js settings
set -x NODE_NO_WARNINGS 1

# Claude Code settings
set -x FORCE_AUTO_BACKGROUND_TASKS 1
set -x ENABLE_BACKGROUND_TASKS 1

# Homebrew settings
set -x HOMEBREW_NO_ENV_HINTS 1

# Path additions
fish_add_path ~/.local/bin
fish_add_path ~/bin

# FZF settings
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

set fish_greeting

#############################################################################

# Homebrew setup
# Detects and configures Homebrew for M-series vs Intel Macs

if test -e /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
else if test -e /usr/local/bin/brew
    eval "$(/usr/local/bin/brew shellenv)"
end

# Homebrew completions
if command -q brew
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
end

#############################################################################

# 1Password CLI Configuration
# Enable CLI completion for 1Password

if command -q op
    op completion fish | source
end

#############################################################################

# Set default terminal for better color support
set -gx TERM "xterm-256color"

#############################################################################

# User configuration
# Always work in a tmux session if tmux is installed
# https://github.com/chrishunt/dot-files/blob/master/.zshrc
if have tmux
  if [ $TERM != "screen-256color" ] && [ $TERM != "screen" ]
    tmux -2u attach-session -t _hack || tmux -2u new -s _hack; exit
  end
end

#############################################################################

# [ -f $TRM/zsh/base.sh ] && source $TRM/zsh/base.sh

#############################################################################


#############################################################################


#############################################################################


#############################################################################


#############################################################################


#############################################################################


#############################################################################

# Starship

if status is-interactive
    if command -q starship
        starship init fish | source
    end
end
