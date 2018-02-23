# FUNCTIONS

echoo() {
  printf "\x1b[34;01m▽ %s\x1b[39;49;00m\n" $1
}

have() {
  type "$1" &> /dev/null
}

##########################################################

# OSX Defaults
H=$(date +%H)
if [[ $OS == 'OSX' ]]; then
  if [[ $H == 8 ]]; then
    # opening and closing windows and popovers
    defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
    # smooth scrolling
    defaults write -g NSScrollAnimationEnabled -bool false
    # showing and hiding sheets, resizing preference windows, zooming windows
    # float 0 doesn't work
    defaults write -g NSWindowResizeTime -float 0.001
    # opening and closing Quick Look windows
    defaults write -g QLPanelAnimationDuration -float 0
    # rubberband scrolling (doesn't affect web views)
    defaults write -g NSScrollViewRubberbanding -bool false
    # resizing windows before and after showing the version browser
    # also disabled by NSWindowResizeTime -float 0.001
    defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
    # showing a toolbar or menu bar in full screen
    defaults write -g NSToolbarFullScreenAnimationDuration -float 0
    # scrolling column views
    defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0
    # showing the Dock
    defaults write com.apple.dock autohide-time-modifier -float 0
    defaults write com.apple.dock autohide-delay -float 0
    # showing and hiding Mission Control, command+numbers
    defaults write com.apple.dock expose-animation-duration -float 0
    # showing and hiding Launchpad
    defaults write com.apple.dock springboard-show-duration -float 0
    defaults write com.apple.dock springboard-hide-duration -float 0
    # changing pages in Launchpad
    defaults write com.apple.dock springboard-page-duration -float 0
    # at least AnimateInfoPanes
    defaults write com.apple.finder DisableAllAnimations -bool true
    # sending messages and opening windows for replies
    defaults write com.apple.Mail DisableSendAnimations -bool true
    defaults write com.apple.Mail DisableReplyAnimations -bool true
  fi
fi

##########################################################

alias ls='ls $LS_OPT' # long list, excludes dot files
alias ll='ls $LS_OPT -GlhA' # long list all, includes dot files
alias l='ls $LS_OPT -1AFC'

alias termieter="cd $TRM"
alias termietere="cd $TRM; vim ."

alias vimd="cd ~/.vim"
alias vime="cd ~/.vim; vim ."

alias v='vim .'
alias vi='vim'

alias ping='echoo "ping -c 5"; ping -c 5' # ping 5 times ‘by default’

alias hosts='sudo vim /etc/hosts'

function compresspdf() {
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH  -dQUIET -sOutputFile=$2 $1
}

if [ -d "$HOME/Work/jackjoe/" ]; then
  alias jackjoe="cd $HOME/Work/jackjoe/"
fi

if [ -d $DROPBOX ]; then
  alias repos="cd $DROPBOX/Work/repos/"
  alias dev="cd $DROPBOX/Work/devel/"
fi

alias largest_files='sudo du -ha / | sort -n -r | head -n 10'

##########################################################

if [[ $OS == 'OSX' ]]; then
  alias cwd='echoo "pwd | pbcopy"; pwd | pbcopy'
  alias cat='ccat'

  # Spotlight
  alias spotlight-stop='sudo mdutil -i off /'
  alias spotlight-clear='sudo mdutil -E /'
  alias spotlight-start='sudo mdutil -i on /'

  # Sleepimage
  alias sleepimage-clear='sudo rm /private/var/vm/sleepimage'

  # MYSQL
  alias mysql-start='launchctl load /usr/local/Cellar/mysql/5.7.19/homebrew.mxcl.mysql.plist'
  alias mysql-stop='launchctl unload /usr/local/Cellar/mysql/5.7.19/homebrew.mxcl.mysql.plist'
  alias mysql-restart='mysql-stop | mysql-start'

  # APACHE
  alias apache-vhosts='vim ~/Dropbox/Work/local-config/httpd-vhosts.conf'
  alias apache-config='sudo vim /usr/local/etc/httpd/httpd.conf'
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
alias gpp='git commit --allow-empty -m "[deploy:production]"'

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
  export GOPATH="$HOME/Work/go"
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

alias n="npm"
alias nr="npm run"

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

# YARN
export PATH="$HOME/.yarn/bin:$PATH"

##########################################################

# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf via local installation
if [ -e ~/.fzf ]; then
  export PATH="$HOME/.fzf/bin:$PATH"
  source ~/.fzf/shell/key-bindings.zsh
  source ~/.fzf/shell/completion.zsh
fi

# fzf + ag configuration
if have fzf && have ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi

##########################################################

# Google Cloud SDK
if [[ $OS == 'OSX' ]]; then
  if [ -d "$DROPBOX/Work/devel/google-coud-sdk" ]; then
    source $DROPBOX/Work/devel/google-cloud-sdk/path.zsh.inc
  fi
else
fi
