# Common functions and aliases for all zsh users, 
# Oh My Zsh or not! (Jeroen does not use the symlinks/.zshrc, that's why...)

# General aliases
alias ls='ls $LS_OPT'       # long list, excludes dot files
alias ll='ls $LS_OPT -GlhA' # long list all, includes dot files
alias l='ls $LS_OPT -1hAFC'
alias mv='mv -i'            # prevents accidental overwrite
alias cp='cp -i'            # prevents accidental overwrite
alias rm='rm -i'            # prevents accidental overwrite
alias termieter="cd $TRM"
alias termietere="cd $TRM; vim ."
alias ping='echoo "ping -c 5"; ping -c 5' # ping 5 times ‘by default’
alias curlg='curl --user-agent "Googlebot/2.1 (+http://www.google.com/bot.html)" -v $@'
alias curlh="curl -I -s -X GET"
alias whereismycam='sudo killall AppleCameraAssistant;sudo killall VDCAssistant'
alias hosts='sudo vim /etc/hosts'
alias m='mosh'
alias sshe='cd ~/.ssh'
alias sshconf='sudo vim ~/.ssh/config'

if [ -d "$HOME/Work/jackjoe/" ]; then
  alias jackjoe="cd $HOME/Work/jackjoe/"
fi

##########################################################

have() {
  type "$1" &> /dev/null
}

# Neovim/Vim
if have nvim; then
  alias v="nvim ."
  alias vim="nvim"
  alias vi="nvim"
  alias vimdiff='nvim -d'
  alias vimd="cd ~/.config/nvim"
  alias vime="vim ~/.config/nvim/lua/init.lua"
else
  alias vimd="cd ~/.vim"
  alias vime="cd ~/.vim; vim ."
  alias v='vim .'
  alias vi='vim'
fi

##########################################################

# Git
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

# Erlang / Elixir
export ERL_AFLAGS="-kernel shell_history enabled"
alias mho="source .env && mix hex.outdated"
alias mdg="source .env && mix deps.get"
alias mdu="source .env && mix deps.update"
alias mdc="source .env && mix deps.clean --all"
alias mm="source .env && mix ecto.migrate"
alias mmm="source .env && mix ecto.gen.migration"
alias mr="make run"
alias mt="source .env.test && mix test $a"

function mpr() {
  source .env && mix phx.routes | grep "$*"
}

##########################################################

# Haskell
export PATH="$PATH:$HOME/.cabal/bin"

##########################################################

# Yarn
alias yy='yarn && yarn upgrade'

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

# fzf via distro
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

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

# ASDF
if [ -e ~/.asdf ]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi