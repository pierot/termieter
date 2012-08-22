if [[ `uname` == 'Darwin' ]]; then
	export LS_OPT=''
elif [[ `uname` == 'Linux' ]]; then
	export LS_OPT='--color=auto'
fi

export HISTCONTROL=erasedups # Erase duplicates
export HISTCONTROL=ignoreboth # Ignore same sucessive entries.
export HISTSIZE=6000 # resize history size

shopt -s histappend # append to bash_history if Terminal.app quits

# PATH
################################################################################################################

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/usr/local/share/python:$PATH"

export PATH="$HOME/.termieter/scripts:$PATH" # Custom scripts 

export PATH

################################################################################################################

export CLICOLOR=1;

export LANG="it_IT.UTF-8"
export LC_COLLATE="it_IT.UTF-8"
export LC_CTYPE="it_IT.UTF-8"
export LC_MESSAGES="it_IT.UTF-8"
export LC_MONETARY="it_IT.UTF-8"
export LC_NUMERIC="it_IT.UTF-8"
export LC_TIME="it_IT.UTF-8"
export LC_ALL=
