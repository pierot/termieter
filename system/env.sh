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

export PATH="$TRM/scripts:$PATH" # Custom scripts 

export PATH

################################################################################################################

export CLICOLOR=1;

export TZ='Europe/Brussels'; 

export LANGUAGE="en_US.UTF-8"
export LANG="C"
export LC_MESSAGES="C"

if [[ `uname` == 'Darwin' ]]; then
  export LANG="en_US.UTF-8"
  export LC_COLLATE="en_US.UTF-8"
  export LC_CTYPE="en_US.UTF-8"
  export LC_MESSAGES="en_US.UTF-8"
  export LC_MONETARY="en_US.UTF-8"
  export LC_NUMERIC="en_US.UTF-8"
  export LC_TIME="en_US.UTF-8"
  export LC_ALL=
fi
