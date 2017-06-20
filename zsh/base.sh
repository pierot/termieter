# FUNCTIONS

echoo() {
  printf "\x1b[34;01m▽ %s\x1b[39;49;00m\n" $1
}

have() {
  type "$1" &> /dev/null
}

##########################################################

alias ls='ls $LS_OPT' # long list, excludes dot files
alias ll='ls $LS_OPT -GlhA' # long list all, includes dot files
alias l='ls $LS_OPT -1AFC'

if [[ $OS == 'OSX' ]]; then
  alias cat='ccat'
fi

alias termieter="cd $TRM"
alias termietere="cd $TRM; vim ."

alias vimd="cd ~/.vim"
alias vime="cd ~/.vim; vim ."

alias v='vim .'
alias vi='vim'

alias ping='echoo "ping -c 5"; ping -c 5' # ping 5 times ‘by default’

alias hosts='sudo vim /etc/hosts'

if [ -d $DROPBOX ]; then
  alias work="cd $DROPBOX/Work/"
  alias archive="cd $DROPBOX/Work/archive/"
  alias repos="cd $DROPBOX/Work/repos/"
  alias jackjoe="cd $DROPBOX/Work/jackjoe/"
  alias dev="cd $DROPBOX/Work/devel/"
fi

alias largest_files='sudo du -ha / | sort -n -r | head -n 10'

##########################################################

if [[ $OS == 'OSX' ]]; then
  alias cwd='echoo "pwd | pbcopy"; pwd | pbcopy'

  # alias mutt='cd ~/Downloads && mutt'

  # Spotlight
  alias spotlight-stop='sudo mdutil -i off /'
  alias spotlight-clear='sudo mdutil -E /'
  alias spotlight-start='sudo mdutil -i on /'

  # Sleepimage
  alias sleepimage-clear='sudo rm /private/var/vm/sleepimage'

  # MYSQL
  alias mysql-start='launchctl load /usr/local/Cellar/mysql/5.7.18_1/homebrew.mxcl.mysql.plist'
  alias mysql-stop='launchctl unload /usr/local/Cellar/mysql/5.7.18_1/homebrew.mxcl.mysql.plist'
  alias mysql-restart='mysql-stop | mysql-start'

  # APACHE
  alias apache-vhosts='sudo vim /private/etc/apache2/extra/httpd-vhosts.conf'
  alias apache-config='sudo vim /private/etc/apache2/httpd.conf'
  alias apache24-config='sudo vim /usr/local/etc/apache2/2.4/httpd.conf'
else
  function list-services() {
    chkconfig --list | grep '3:on'
  }

  function active-connections() {
    netstat -tulpn
  }
fi

##########################################################

# SVN
export SVN_EDITOR='vim'

##########################################################

# GIT
alias glod='gl origin develop'
alias glos='gl origin staging'
alias glom='gl origin master'
alias gcompile='git add . && gcmm compile'
alias gmerge='git add . && gcmm merge'

function gpo() {
  git pull origin $*
}

function gcmm() {
  gc -m "$*"
}

function gcm() {
  gc -m "$*"
}

git-status-all() {
  for gitdir in `find . -name .git`;
  do
    local workdir=$(dirname $gitdir);
    local gitout="`git -c color.status=always --git-dir=$gitdir --work-tree=$workdir status`";

    if [[ ! $gitout =~ .*nothing\ to\ commit,\ working\ directory\ clean.* ]];
    then
      echo;
      echo $workdir;
      echo $gitout;
      echo "###########################################";
    fi
  done
}

##########################################################

# TMUX
alias t='tmux'
alias tk='tmux kill-server'
alias ta='tmux attach-session -t $@'
alias tl='tmux ls'

test "$(uname -s)" = "Darwin" && tmux_wrapper=reattach-to-user-namespace

# function tt-mail() {
#   tmux has-session -t mutt 2>/dev/null
#   if [ "$?" -eq 1 ] ; then
#     tmux new-session -d -s "mutt" "$tmux_wrapper -l $SHELL"
#   fi
# }

# function tt() {
#   # tt-mail
#
#   # var for session name (to avoid repeated occurences)
#   sn=`echo ${PWD##*/}`
#
#   # This will also be the default cwd for new windows created
#   # tmux new-session -d -s "$sn" "$tmux_wrapper vim ."
#   tmux new-session -d -s "$sn" "$tmux_wrapper -l $SHELL"
#
#   # New window
#   tmux new-window -t "$sn:2" "$tmux_wrapper -l $SHELL"
#
#   # Select window #1 and attach to the session
#   tmux select-window -t "$sn:1"
#   tmux -2 attach-session -t "$sn"
# }

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color

##########################################################

# RBENV
# if have rbenv; then
#   eval "$(rbenv init -)"
# else
#   if [ -s "~/.rbenv/bin" ]; then
#     export PATH="$PATH:$HOME/.rbenv/bin"
#     eval "$(rbenv init -)"
#   elif [ -s "/usr/local/rbenv/bin" ]; then
#     export PATH="$PATH:/usr/local/rbenv/bin"
#     eval "$(rbenv init -)"
#   fi
# fi

##########################################################

# GO
if [[ $OS == 'OSX' ]]; then
  export GOPATH="$DROPBOX/Work/go"
  export GOROOT="/usr/local/opt/go/libexec"
else
  export GOROOT="/usr/lib/go"
  export GOPATH="$HOME/go"
fi

export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

alias godir="cd $GOPATH"

##########################################################

# ANDROID
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$HOME/Library/Android/sdk/tools"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/emulator"

##########################################################

# NODE
export PATH="$PATH:/usr/local/share/npm/bin"
export PATH="$PATH:$HOME/.node/bin"

##########################################################

# HASKELL
export PATH="$PATH:$HOME/.cabal/bin"

##########################################################

# FASTLANE
export PATH="$PATH:$HOME/.fastlane/bin"

##########################################################

# MYSQL
export PATH="$PATH:/usr/local/mysql/bin"

##########################################################
