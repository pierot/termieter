# Common functions and aliases for all zsh users,
# Oh My Zsh or not! (Jeroen does not use the symlinks/.zshrc, that's why...)

# General aliases
if have exa; then
  alias ls="exa"
  alias ll="exa --icons -l"
  alias la="exa --icons -la"
  alias l="exa --icons -la"
else
  alias ls='ls $LS_OPT'       # long list, excludes dot files
  alias ll='ls $LS_OPT -GlhA' # long list all, includes dot files
  alias l='ls $LS_OPT -1hAFC'
fi

if have eza; then
  alias ls="eza"
  alias ll="eza --icons -la"
  alias l="eza --icons -l"
fi

if have rg; then
  alias grep="rg"
fi

if have fd; then
  alias find="fd"
fi

alias mv='mv -i'            # prevents accidental overwrite
alias cp='cp -i'            # prevents accidental overwrite
alias rm='rm -i'            # prevents accidental overwrite
alias cpf='cp'              # no prevention
alias mvf='mv'              # no prevention

alias termieter="cd $TRM"
alias termietere="cd $TRM; vim ."

alias ping='echoo "ping -c 5"; ping -c 5' # ping 5 times ‘by default’
alias curlg='curl --user-agent "Googlebot/2.1 (+http://www.google.com/bot.html)" -v $@'
alias curlh="curl -I -s -X GET"
alias myip='curl -s https://ipinfo.io/ip'

alias sshe='cd ~/.ssh'
alias sshconf='sudo vim ~/.ssh/config'

##########################################################

# TMUX

test "$(uname -s)" = "Darwin" && tmux_wrapper=reattach-to-user-namespace

alias tmux="tmux -2u"  # 2: for 256color u: to get rid of unicode rendering problem
alias tk="tmux kill-server"
alias ta="tmux attach-session -t $@"
alias tl="tmux ls"

function tn() {
  tmux new -d -c "$PWD" -s "$*"
  tmux attach-session -t "$1"
}

##########################################################

# Work / Projects

if [ -d "$HOME/Work/jackjoe/" ]; then
  alias jackjoe="cd $HOME/Work/jackjoe/"
fi

alias mr="make run"

##########################################################

function connect_traefik() {
  echo "http://localhost:9446 (port on host is 9445)"
	ssh -L 9446:localhost:9445 "jackjoe@$@" -nNT
}

function connect_caddy() {
  echo "http://localhost:2019 (port on host is 2019)"
	ssh -L 2019:localhost:2019 "jackjoe@$@" -nNT
}

##########################################################

# Neovim/Vim
if have nvim; then
  alias v="nvim ."
  alias vim="nvim"
  alias vi="nvim"
  alias vimdiff='nvim -d'
  alias vimd="cd ~/.vim"
  alias vime="vim ~/.config/nvim"
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

alias gap='git add -p'
alias gst='git status'

alias gd="git diff"

alias gdoc='git add . && gcmm docs: add documentation'
alias gmerge='git add . && gcmm chore: merge'
alias gcompile='git add . && gcmm chore: compile'
alias gcopy='git add . && gcmm copy'
alias gbump='git add . && gcmm chore: bump versions'
alias gcleanup='git add . && gcmm chore: cleanup'
alias gprogress='git add . && gcmm chore: progress'
alias gfix='git add . && gcmm fix'
alias gtweak='git add . && gcmm tweak'
alias gamend='git commit --amend --no-edit'

gpo() {
  git pull origin $*
}

gcmm() {
  gc -m "$*"
}

git-status-all() {
  for gitdir in `find . -name .git`;
  do
    local workdir="$(dirname "$gitdir")"
    local gitout="$(git -c color.status=always --git-dir="$gitdir" --work-tree="$workdir" status)"

    if [[ ! $gitout =~ .*nothing\ to\ commit,\ working\ directory\ clean.* ]];
    then
      echo
      echo "$workdir"
      echo "$gitout"
      echo "###########################################"
    fi
  done
}

# Find worktree directory, checking both .worktrees and worktrees
gwt_find_dir() {
  local branch="$1"
  if [ -d ".worktrees/$branch" ]; then
    echo ".worktrees/$branch"
  elif [ -d "worktrees/$branch" ]; then
    echo "worktrees/$branch"
  else
    echo ""
  fi
}

# Create a new worktree for a branch and cd into it
gwt_create() {
  # Usage: gwt_create <branch> [<base-branch>]
  local branch="$1"
  local base="$2"
  if [ -z "$base" ]; then
    echo -n "No base branch specified. Use current branch? (y/n) "
    read -r answer
    [[ "$answer" != [yY] ]] && return 1
  fi
  local dir="${GWT_DIR:-worktrees}/$branch"
  git worktree add -b "$branch" "$dir" "$base" && cd "$dir"
}

# List all worktrees
gwt_list() {
  git worktree list
}

# Go to a worktree directory
gwt_cd() {
  # Usage: gwtg <branch>
  cd "$(git worktree list | grep "/$1 " | awk '{print $1}')"
}

# Merge a worktree branch into a target branch, remove the worktree and branch
gwt_merge() {
  # Usage: gwtm <worktree-branch> <target-branch>
  local src="$1"
  local target="${2:-main}"
  local dir="$(gwt_find_dir "$src")"
  [ -z "$dir" ] && echo "Worktree not found" && return 1
  cd "$(git rev-parse --show-toplevel)"
  git checkout "$target" || return 1
  git pull
  git merge "$src"
  git worktree remove "$dir"
  git branch -d "$src"
}

# Remove a worktree and its branch
gwt_rm() {
  # Usage: gwtrm <branch>
  local branch="$1"
  local dir="$(gwt_find_dir "$branch")"
  [ -z "$dir" ] && echo "Worktree not found" && return 1
  git worktree remove "$dir"
  git branch -D "$branch"
}

gwt_info() {
  cat <<'EOF'
gwt_create <branch> [<base-branch>]
  Create a new worktree for <branch> (from <base-branch>, default: main) in worktrees/<branch> and cd into it.
  Example: gwtc feature/foo develop

gwt_list
  List all git worktrees.

gwt_cd <branch>
  cd into the worktree directory for <branch>.
  Example: gwtg feature/foo

gwt_merge <worktree-branch> [<target-branch>]
  Merge <worktree-branch> into <target-branch> (default: main), remove the worktree and delete the branch.
  Example: gwtm feature/foo develop

gwt_rm <branch>
  Remove the worktree and delete the branch for <branch>.
  Example: gwtrm feature/foo

gwt_info
  Show this help/documentation.
EOF
}

##########################################################

# Erlang / Elixir
export ERL_AFLAGS="-kernel shell_history enabled"
export MIX_OS_DEPS_COMPILE_PARTITION_COUNT=$(( $(nproc --all 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 2) / 2 ))

alias mho="source .env && mix hex.outdated"
alias mdg="source .env && mix deps.get"
alias mdu="source .env && mix deps.update"
alias mdc="source .env && mix deps.clean --all"
alias mm="source .env && mix ecto.migrate"
alias mmc="source .env && mix ecto.gen.migration"
alias mc="source .env && mix compile"
alias mt="source .env.test && mix test $a"
alias mtf="source .env.test && mix test --failed"

mpr() {
  source .env && mix phx.routes | grep "$*"
}

##########################################################

# Haskell
export PATH="$PATH:$HOME/.cabal/bin"

##########################################################

# Yarn, pnpm
alias yy='yarn && yarn upgrade'

alias p='pnpm'

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

##########################################################

alias flyc='fly ssh console -C "./opt/app/bin/production remote" -a'

##########################################################

# fzf configuration - optimized for performance
if have fzf; then
  # Set default command (fd > rg > ag)
  if have fd; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
  elif have rg; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
  elif have ag; then
    export FZF_DEFAULT_COMMAND='ag --nocolor --hidden -g ""'
  fi

  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  # Performance & UI options
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --inline-info --cycle --bind ctrl-/:toggle-preview --bind ctrl-u:preview-page-up --bind ctrl-d:preview-page-down'

  # CTRL-T with file preview (if bat available)
  if have bat; then
    export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target,.next --preview 'bat --color=always --style=numbers --line-range=:500 {}' --preview-window right:60%:wrap"
  fi

  # ALT-C with directory preview
  export FZF_ALT_C_OPTS="--preview 'ls -la {}'"

  # Load fzf shell integrations
  # Homebrew (Intel)
  if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
  # Homebrew (Apple Silicon)
  elif [ -e /opt/homebrew/opt/fzf/shell/completion.zsh ]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
  # Local installation
  elif [ -e ~/.fzf ]; then
    export PATH="$HOME/.fzf/bin:$PATH"
    source ~/.fzf/shell/key-bindings.zsh
    source ~/.fzf/shell/completion.zsh
  # Distro package
  elif [ -f /usr/share/fzf/completion.zsh ]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
  fi
fi

if have gsed; then
  alias sed='gsed'
fi

if have bat; then
  alias cat='bat'
elif have ccat; then
  alias cat='ccat'
fi

if have gdircolors; then
  alias dircolors='gdircolors'
fi

##########################################################

# ASDF
export PATH="$HOME/.asdf/shims:$PATH"

##########################################################
