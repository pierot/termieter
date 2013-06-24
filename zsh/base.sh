# FUNCTIONS

echoo() {
  printf "\x1b[34;01m▽ %s\x1b[39;49;00m\n" $1
}

have() {
  type "$1" &> /dev/null
}

function fasterfaster() {
  sudo rm -rf /private/var/log/asl/*
  sudo rm -rf /var/mail/*
}

###############################################################################

alias termieter="cd $TRM"
alias termietere="cd $TRM; vim ."
alias vime="cd ~/.vim; vim ."

alias v='vim .'
alias vi='vim'

alias l='ls $LS_OPT -1AFC'

alias ip='dig +short myip.opendns.com @resolver1.opendns.com' # my ip
alias ping='echoo "ping -c 5"; ping -c 5' # ping 5 times ‘by default’

alias msh-noort='mosh --ssh="ssh -p 33" pierot@noort.be'

alias hosts='sudo vim /etc/hosts'

if [ -d $DROPBOX ]; then
  alias repos="cd $DROPBOX/Work/repos/"
  alias dev="cd $DROPBOX/Work/devel/"
  alias clients="cd $DROPBOX/Work/clients/"
  alias projects="cd ~/Documents/Projects/"
fi

###############################################################################

if [[ $OS == 'OSX' ]]; then
  alias cwd='echoo "pwd | pbcopy"; pwd | pbcopy'

  alias mutt='cd ~/Downloads && mutt'

  # Spotlight
  alias spotlight-stop='sudo mdutil -i off /'
  alias spotlight-clear='sudo mdutil -E /'
  alias spotlight-start='sudo mdutil -i on /'

  # Sleepimage
  alias sleepimage-clear='sudo rm /private/var/vm/sleepimage'

  function fix-fonts() {
    echoo "atsutil databases -removeUser; atsutil server -shutdown; atsutil server -ping"

    atsutil databases -removeUser
    atsutil server -shutdown
    atsutil server -ping
  }

  # MYSQL
  alias mysql-start='launchctl load /usr/local/Cellar/mysql/5.6.10/homebrew.mxcl.mysql.plist'
  alias mysql-stop='launchctl unload /usr/local/Cellar/mysql/5.6.10/homebrew.mxcl.mysql.plist'
  alias mysql-restart='mysql-stop | mysql-start'

  # APACHE
  alias apache-start='sudo apachectl start'
  alias apache-restart='sudo apachectl restart'
  alias apache-stop='sudo apachectl stop'

  alias apache-vhosts='sudo vim /private/etc/apache2/extra/httpd-vhosts.conf'
  alias apache-config='sudo vim /private/etc/apache2/httpd.conf'
else
  function list-services() {
    chkconfig --list | grep '3:on'
  }

  function active-connections() {
    netstat -tulpn
  }

  function iptables-clear() {
    iptables -F
    iptables -X
    iptables -t nat -F
    iptables -t nat -X
    iptables -t mangle -F
    iptables -t mangle -X
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -P FORWARD ACCEPT
  }
fi

###############################################################################

# SVN
export SVN_EDITOR='vim'

alias svns='svn st'
alias svnc='svn commit -m "$@"'
alias svnu='svn up'

svn-add-all() {
  svn st | grep "^?" | awk '{$1=""; print $0}' | while read f; do svn add "$f"; done
}

svn-delete-all() {
  svn st | grep '^\!' | sed 's/! *//' | xargs -I% svn rm %
}

alias svn-status-all="$FT/svnstatus.py $@"
alias svn-up-all="$FT/functions/svnup.py $@"
alias svn-update-all='svn-up-all'

###############################################################################

# TMUX
alias t='tmux'
alias tk='tmux kill-server'
alias ta='tmux attach-session -t $@'
alias tl='tmux ls'

source "$FT/reattach-to-user-namespace.sh"

function tt-mail() {
  tmux has-session -t mutt 2>/dev/null

  if [ "$?" -eq 1 ] ; then
    tmux new-session -d -s "mutt" "reattach-to-user-namespace -l $SHELL"
  fi
}

function tt() {
  tt-mail

  # var for session name (to avoid repeated occurences)
  sn=`echo ${PWD##*/}`

  # This will also be the default cwd for new windows created
  tmux new-session -d -s "$sn" "reattach-to-user-namespace -l vim ."

  # New window
  tmux new-window -t "$sn:2" "reattach-to-user-namespace -l $SHELL"

  # Select window #1 and attach to the session
  tmux select-window -t "$sn:1"
  tmux -2 attach-session -t "$sn"
}

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color

###############################################################################

# SCREEN
alias screen='export SCREENPWD=$(pwd); /usr/bin/screen -U -T $TERM'
alias s='export SCREENPWD=$(pwd); /usr/bin/screen -U -T $TERM'

case "$TERM" in
  'screen')
     cd $SCREENPWD
     ;;
esac

###############################################################################

# RBENV
if have rbenv; then
  eval "$(rbenv init -)"
else
  if [ -s "~/.rbenv/bin" ]; then
    export PATH="~/.rbenv/bin:$PATH"

    eval "$(rbenv init -)"
  elif [ -s "/usr/local/rbenv/bin" ]; then
    export PATH="/usr/local/rbenv/bin:$PATH"

    eval "$(rbenv init -)"
  fi
fi
