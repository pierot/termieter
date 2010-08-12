# Global settings for Terminal environment

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

#export TERM="xterm-color"

alias ls="ls -G"

#PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "

function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
local        BLUE="\[\033[0;34m\]"
local         RED="\[\033[0;31m\]"
local   LIGHT_RED="\[\033[1;31m\]"
local       GREEN="\[\033[0;32m\]"
local LIGHT_GREEN="\[\033[1;32m\]"
local       WHITE="\[\033[1;37m\]"
local  LIGHT_GRAY="\[\033[0;37m\]"

case $TERM in
  xterm*)
  TITLEBAR='\[\033]0;\u@\h:\w\007\]'
  ;;
  *)
  TITLEBAR=""
  ;;
esac

PS1="${TITLEBAR}\
$GREEN[$GREEN\$(date +%H:%M)$GREEN]\
$GREEN[$GREEN\u@\h:\w$WHITE\$(parse_git_branch)$GREEN]\
$GREEN\$ "
PS2='> '
PS4='+ '
}

proml

# SPECIAL FUNCTIONS
######################################################################################################
