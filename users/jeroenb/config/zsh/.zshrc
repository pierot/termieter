# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Remember to put this in your .zshenv file
# export ZDOTDIR=$HOME/.config/zsh
#
# For plugins, use Antidote: https://getantidote.github.io/install
# yay -S zsh-antidote

# <Antidote START>
source '/usr/share/zsh-antidote/antidote.zsh'

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# prompt
autoload -Uz promptinit && promptinit && prompt powerlevel10k

# </Antidote END>

# Autocomplete
# Load bash autocomplete for asdf
[ -f $HOME/.asdf/completions/asdf.bash ] && autoload -U +X bashcompinit && bashcompinit 

##########
# HISTORY
##########

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Dont write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # remove unnecessary blanks

setopt inc_append_history
setopt share_history             # Reloads the history whenever you use it

# Set options (see man zshoptions)
setopt extendedglob nomatch menucomplete interactive_comments
setopt autocd                   # Automatically cd into typed directory.
setopt notify                   # Report the status of background jobs immediately, rather than
                                # waiting until just before printing a prompt.
setopt extendedhistory          # Save timestamp in history
setopt inc_append_history       # Appends every command to the history file once it is executed

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'    # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Color for ls 
zstyle ':completion:*' menu no                            # Disable for fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

###############
# KEY BINDINGS
###############
bindkey '^R' .history-incremental-search-backward
bindkey '^S' .history-incremental-search-forward


# Load extra files if present (aliases must come after common)
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions.sh"

# Common settings shared with termieter (Pieter), after loading functions!
source $TRM/zsh/common.sh

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases.sh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
