#!/bin/zsh

echoo() {
  printf "\x1b[34;01m▽ %s\x1b[39;49;00m\n" $1
}

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
bindkey '^i' edit-command-line

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null

# force emacs style keybindings...
bindkey -e
