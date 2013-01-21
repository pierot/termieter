alias termieter="cd $TRM"
alias termietere="cd $TRM; vim ."

alias vime="cd $HOME/.vim; vim ."

alias reload!=". $HOME/.bash_profile"

################################################################################################################

alias ls='ls $LS_OPT' # long list, excludes dot files
alias ll='ls $LS_OPT -GlhA' # long list all, includes dot files
alias l='ls $LS_OPT -1AFC' 

alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'" # Get readable list of network IPs
alias ip='dig +short myip.opendns.com @resolver1.opendns.com' # my ip

alias gzip='echo "» gzip -9n"; gzip -9n' # set strongest compression level as ‘default’ for gzip
alias ping='echo "» pint -c 5"; ping -c 5' # ping 5 times ‘by default’

alias hist='history | grep "$@"'
alias hist-sort='history | cut -c 8- | sort | uniq -c | sort -rn'

alias msh-noort='mosh --ssh="ssh -p 33" root@noort.be'
alias msh-info='open http://mosh.mit.edu/#about'

alias v='vim .'

# Server
alias ssh-config="vim $HOME/.ssh/config"

# SJL T
alias t="$TRM/system/functions/sjl-t/t.py --task-dir $HOME/Dropbox/Private/tasks --list tasks"

################################################################################################################

export DROPBOX=$HOME/Dropbox

if [ -d $DROPBOX ]; then
  alias repos="cd $DROPBOX/Work/repos/"
  alias github="cd $DROPBOX/Work/repos/github/"
  alias dev="cd $DROPBOX/Work/devel/"
  alias clients="cd $DROPBOX/Work/clients/"
  alias projects="cd $HOME/Documents/Projects/"
fi

################################################################################################################

if [[ $OS == 'OSX' ]]; then
  alias flushdns='echo "» dscacheutil -flushcache"; dscacheutil -flushcache' # Flush DNS cache
  alias hosts='sudo vim /private/etc/hosts'

  # Trash a file from your Terminal
  alias trash='mv "$@" ~/.Trash/'

  # copy current working directory to clipboard
  alias cwd='pwd | pbcopy' 
else
  alias hosts='sudo vim /etc/hosts'
  alias sys-update='sudo apt-get update && sudo apt-get upgrade'
fi
