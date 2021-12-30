# FUNCTIONS

largest_files() {
  sudo du -ha / | sort -n -r | head -n 10
}

compresspdf() {
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH  -dQUIET -sOutputFile=$2 $1
}

echoo() {
  printf "\x1b[34;01m▽ %s\x1b[39;49;00m\n" $1
}

have() {
  type "$1" &> /dev/null
}

# Create a data URL from a file
dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

if [[ $OS == 'OSX' ]]; then
  changeMac() {
    local mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
    sudo ifconfig en0 ether $mac
    sudo ifconfig en0 down
    sudo ifconfig en0 up
    echo "Your new physical address is $mac"
  }
fi

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

    # Keyrepeat
    defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
  fi
fi

##########################################################

if have nvim; then
  export EDITOR=nvim
  export SVN_EDITOR='nvim'
else
  export SVN_EDITOR='vim'
  export EDITOR=vim
fi

##########################################################

if [[ $OS == 'OSX' ]]; then
  alias cwd='echoo "pwd | pbcopy"; pwd | pbcopy'
  alias cat='ccat'
  alias zzz='pmset sleepnow'

  # Spotlight
  alias spotlight-stop='sudo mdutil -i off /'
  alias spotlight-clear='sudo mdutil -E /'
  alias spotlight-start='sudo mdutil -i on /'

  # Sleepimage
  alias sleepimage-clear='sudo rm /private/var/vm/sleepimage'

  # APACHE
  alias apache-vhosts='sudo vim /usr/local/etc/httpd/extra/httpd-vhosts.conf'
  alias apache-config='sudo vim /usr/local/etc/httpd/httpd.conf'
  alias php-error-tail='tail -f /usr/local/var/log/httpd/error_log'
else
  function list-services() {
    chkconfig --list | grep '3:on'
  }

  function active-connections() {
    netstat -tulpn
  }

  function fix-apt() {
    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock
  }
fi

##########################################################

# TMUX
alias tmux="tmux -2u"  # 2: for 256color u: to get rid of unicode rendering problem
alias tk="tmux kill-server"
alias ta="tmux attach-session -t $@"
alias tl="tmux ls"

function tn() {
  tmux new -d -c "$PWD" -s "$*"
  tmux attach-session -t $1
}

test "$(uname -s)" = "Darwin" && tmux_wrapper=reattach-to-user-namespace

# for tmux: export 256color
# [ -n "$TMUX" ] && export TERM=screen-256color

##########################################################

function connect_traefik() {
	echo "http://localhost:9446"
	ssh -L 9446:localhost:9445 "jackjoe@$@" -nNT
}

# Ruby
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

export PATH="$PATH:/Library/Ruby/Gems/2.3.0"

##########################################################

alias python=/usr/local/bin/python3

##########################################################

# GO
if [[ $OS == 'OSX' ]]; then
  export GOPATH="$HOME/Work/go"
  export GOROOT="/usr/local/opt/go/libexec"
else
  export GOPATH="$HOME/go"
  export GOROOT="/usr/lib/go"
fi

export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

alias godir="cd $GOPATH"

##########################################################

# HASKELL
export PATH="$PATH:$HOME/.cabal/bin"

##########################################################

# MYSQL
export PATH="$PATH:/usr/local/mysql/bin"

##########################################################

# YARN
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias yy='yarn && yarn upgrade'

# NODE
export PATH="$PATH:/usr/local/share/npm/bin"
export PATH="$PATH:$HOME/.node/bin"

alias n="npm"
alias nr="npm run"

##########################################################

# IC4C
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

##########################################################

if [ -e ~/.base.sh.local ]; then
  source ~/.base.sh.local
fi

# Common stuff for both base.sh (oh-my-zsh) users and 
# users that just want some common stuff
source ~/.termieter/zsh/common.sh

if [[ $OS == 'OSX' ]]; then
  source ~/.termieter/zsh/osx.sh
fi
