#!/bin/zsh

# Remember to put this in your .zshenv file
# export ZDOTDIR=$HOME/.config/zsh

# Set options (see man zshoptions)
setopt extendedglob nomatch menucomplete interactive_comments
setopt autocd                   # Automatically cd into typed directory.
setopt notify                   # Report the status of background jobs immediately, rather than
                                # waiting until just before printing a prompt.
setopt extendedhistory          # Save timestamp in history
setopt inc_append_history       # Appends every command to the history file once it is executed
setopt share_history            # Reloads the history whenever you use it
#stty stop undef		              # Disable ctrl-s to freeze terminal.

typeset -U PATH                 # no duplicates in path

# Autocomplete
autoload -Uz compinit promptinit
fpath=(/usr/local/share/zsh-completions $fpath)
zstyle ':completion:*' menu yes=long select
zstyle ':completion:*' use-cache yes
zstyle ':completion:*:functions' ignored-patterns '_*'
zmodload zsh/complist
_comp_options+=(globdots)		    # Include hidden files

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

autoload -Uz colors && colors   # Colors

# History
# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS     # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS        # do not save duplicated command
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY         # record command start time

# Load extra files if present
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions.sh"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases.sh"

# vi mode
# bindkey -v
# export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
# function zle-keymap-select () {
#     case $KEYMAP in
#         vicmd) echo -ne '\e[1 q';;      # block
#         viins|main) echo -ne '\e[5 q';; # beam
#     esac
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Common settings shared with termieter (Pieter)
source $TRM/zsh/common.sh

# Pure prompt, make sure you have it installed into ~/.config/zsh/pure
# git clone https://github.com/sindresorhus/pure.git ~/config/zsh/pure
fpath+=$HOME/.config/zsh/pure

# Kick off zsh
compinit
promptinit

prompt pure

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey -s '^q' 'bc -lq\n'

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null
