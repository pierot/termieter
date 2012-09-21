alias termieter="cd $TRM"
alias termietere="cd $TRM; vim ."

alias vime='cd ~/.vim; vim .'

alias reload!='. ~/.bash_profile'

################################################################################################################

alias ls='ls $LS_OPT' # long list, excludes dot files
alias ll='ls $LS_OPT -GlhA' # long list all, includes dot files
# alias l='ls $LS_OPT -goFA' 
alias l='ls $LS_OPT -1AF' 

alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'" # Get readable list of network IPs
alias ip='dig +short myip.opendns.com @resolver1.opendns.com' # my ip
alias flushdns='echo "» dscacheutil -flushcache"; dscacheutil -flushcache' # Flush DNS cache

alias gzip='echo "» gzip -9n"; gzip -9n' # set strongest compression level as ‘default’ for gzip
alias ping='echo "» pint -c 5"; ping -c 5' # ping 5 times ‘by default’

alias cwd='pwd | pbcopy' # copy current working directory to clipboard

alias hosts='sudo vim /private/etc/hosts'

alias hist='history | grep "$@"'
alias hist-sort='history | cut -c 8- | sort | uniq -c | sort -rn'

alias v='vim .'

# Trash a file from your Terminal
alias trash='mv "$@" ~/.Trash/'

# SSH background color
alias ssh="echo '» ssh-host-color-iterm'; $TRM/system/functions/ssh-host-color-iterm"

# Server
alias ssh-config="vim $HOME/.ssh/config"
alias server-keys="l $HOME/.servers/*"

# paths
################################################################################################################

export DROPBOX=$HOME/Dropbox

if [ -d $DROPBOX ]; then
  alias repos="cd $DROPBOX/Work/repos/"
  alias github="cd $DROPBOX/Work/repos/github/"
  alias dev="cd $DROPBOX/Work/devel/"
  alias clients="cd $DROPBOX/Work/clients/"
  alias projects="cd $HOME/Documents/Projects/"
fi
