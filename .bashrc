# HISTORY
######################################################################################################

export HISTCONTROL=erasedups # Erase duplicates
export HISTSIZE=5000 # resize history size

shopt -s histappend # append to bash_history if Terminal.app quits

# EDITOR
######################################################################################################

export EDITOR='mate -w'

# COLORS
######################################################################################################

export TERM="xterm-color"

alias ls="ls -G"

PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "

# SPECIAL FUNCTIONS
######################################################################################################
