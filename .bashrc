# Global settings for Terminal environment

# HISTORY
######################################################################################################

export HISTCONTROL=erasedups # Erase duplicates
export HISTSIZE=5000 # resize history size

shopt -s histappend # append to bash_history if Terminal.app quits

# NATIVE ALIASES
######################################################################################################

export EDITOR='mate -w'

alias ls="ls -l"

# COLORS
######################################################################################################

function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 34 ]; then CurDir=${DIR:0:14}...${DIR:${#DIR}-17}; else CurDir=$DIR; fi'
PS1="[\u:\$CurDir:\$(parse_git_branch)]\\$  "

#function proml {
#local        BLUE="\[\033[0;34m\]"
#local         RED="\[\033[0;31m\]"
#local   LIGHT_RED="\[\033[1;31m\]"
#local       GREEN="\[\033[0;32m\]"
#local LIGHT_GREEN="\[\033[1;32m\]"
#local       WHITE="\[\033[1;37m\]"
#local  LIGHT_GRAY="\[\033[0;37m\]"
#
#case $TERM in
#  xterm*)
#  TITLEBAR='\[\033]0;\u@\h:\w\007\]'
#  ;;
#  *)
#  TITLEBAR=""
#  ;;
#esac
#
#PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 34 ]; then CurDir=${DIR:0:14}...${DIR:${#DIR}-17}; else CurDir=$DIR; fi'
#PS1="[$GREEN\u:\$CurDir:$WHITE\$(parse_git_branch)$GREEN]\$GREEN\$  "
#PS2='> '
#PS4='+ '
#}
#
#proml

# SPECIAL FUNCTIONS
######################################################################################################


