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

if [[ $OS == 'OSX' ]]; then
  changeMac() {
    local mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
    sudo ifconfig en0 ether $mac
    sudo ifconfig en0 down
    sudo ifconfig en0 up
    echo "Your new physical address is $mac"
  }

  tweakMac() {
    # opening and closing Quick Look windows
    defaults write -g QLPanelAnimationDuration -float 0

    # sending messages and opening windows for replies
    defaults write com.apple.Mail DisableSendAnimations -bool true
    defaults write com.apple.Mail DisableReplyAnimations -bool true

    # Keyrepeat
    defaults write -g InitialKeyRepeat -int 13 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
  }

  alias whereismycam='sudo killall AppleCameraAssistant;sudo killall VDCAssistant'

  alias cwd='echoo "pwd | pbcopy"; pwd | pbcopy'
  alias zzz='pmset sleepnow'

  # Spotlight
  alias spotlight-stop='sudo mdutil -i off /'
  alias spotlight-clear='sudo mdutil -E /'
  alias spotlight-start='sudo mdutil -i on /'

  # Sleepimage
  alias sleepimage-clear='sudo rm /private/var/vm/sleepimage'
else
  list-services() {
    chkconfig --list | grep '3:on'
  }

  active-connections() {
    netstat -tulpn
  }

  fix-apt() {
    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock
  }
fi

##########################################################

alias hosts='sudo vim /etc/hosts'

if have nvim; then
  export EDITOR=nvim
  export SVN_EDITOR='nvim'
else
  export SVN_EDITOR='vim'
  export EDITOR=vim
fi

##########################################################

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

# MYSQL
export PATH="$PATH:/usr/local/mysql/bin"

##########################################################

# YARN
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

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
