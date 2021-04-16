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

alias ls='ls $LS_OPT'       # long list, excludes dot files
alias ll='ls $LS_OPT -GlhA' # long list all, includes dot files
alias l='ls $LS_OPT -1AFC'
alias mv='mv -i'            # prevents accidental overwrite

alias termieter="cd $TRM"
alias termietere="cd $TRM; vim ."

alias vimd="cd ~/.vim"
alias vime="cd ~/.vim; vim ."

alias v='vim .'
alias vi='vim'

alias ping='echoo "ping -c 5"; ping -c 5' # ping 5 times ‘by default’
alias curlg='curl --user-agent "Googlebot/2.1 (+http://www.google.com/bot.html)" -v $@'
alias curlh="curl -I -s -X GET"
alias whereismycam='sudo killall AppleCameraAssistant;sudo killall VDCAssistant'

alias hosts='sudo vim /etc/hosts'
alias m='mosh'

if [ -d "$HOME/Work/jackjoe/" ]; then
  alias jackjoe="cd $HOME/Work/jackjoe/"
fi

##########################################################

if [[ $OS == 'OSX' ]]; then
  alias cwd='echoo "pwd | pbcopy"; pwd | pbcopy'
  alias cat='ccat'
  alias zzz='pmset sleepnow'

  # ssh
  alias sshconf='sudo nvim ~/.ssh/config'
  alias sshe='cd ~/.ssh'

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

# EDITORS
export SVN_EDITOR='nvim'
export EDITOR=vim

##########################################################

# GIT
alias gl='git pull'
alias gp='git push'
alias gc='git commit'
alias gco='git checkout'

alias glod='gl origin develop'
alias glos='gl origin staging'
alias glom='gl origin master'

alias gap='git add -p'
alias gst='git status'

alias gdoc='git add . && gcmm docs: add documentation'
alias gmerge='git add . && gcmm chore: merge'
alias gcompile='git add . && gcmm chore: compile'
alias gbump='git add . && gcmm chore: bump versions'
alias gcleanup='git add . && gcmm chore: cleanup'
alias gammend='git commit --amend --no-edit'

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
alias tmux="tmux -2u"  # 2: for 256color u: to get rid of unicode rendering problem
alias tk="tmux kill-server"
alias ta="tmux attach-session -t $@"
alias tl="tmux ls"

function tn() {
  tmux new -d -c "$PWD" -s "$*"
}

test "$(uname -s)" = "Darwin" && tmux_wrapper=reattach-to-user-namespace

# for tmux: export 256color
# [ -n "$TMUX" ] && export TERM=screen-256color

##########################################################

function connect_traefik() {
	echo "http://localhost:9446"
	ssh -L 9446:localhost:9445 "jackjoe@$@" -nNT
}

##########################################################

# ERLANG / ELIXIR
export ERL_AFLAGS="-kernel shell_history enabled"

# Mix (Elixir)

alias mho="source .env && mix hex.outdated"
alias mdg="source .env && mix deps.get"
alias mdu="source .env && mix deps.update"
alias mdc="source .env && mix deps.clean --all"
alias mm="source .env && mix ecto.migrate"
alias mmm="source .env && mix ecto.migration"

function mpr() {
  source .env && mix phx.routes | grep "$*"
}

alias mr="make run"
alias mt="source .env.test && mix test $a"

##########################################################

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
if have fzf; then
  if have fd; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  elif have rg; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden -g !.git'
  elif have ag; then
    export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  fi
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

##########################################################

# ASDF
if [ -e ~/.asdf ]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi

##########################################################

if [ -e ~/.base.sh.local ]; then
  source ~/.base.sh.local
fi
