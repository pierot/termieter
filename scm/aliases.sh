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

alias svn-status-all="$TRM/svn/functions/svnstatus.py $@"
alias svn-up-all="$TRM/svn/functions/svnup.py $@"
alias svn-update-all='svn-up-all'

# GIT
alias gst='echo "» git status"; git status'
alias gp='echo "» git push"; git push "$@"'
alias gcam='echo "» git commit -a -m"; git commit -a -m "$@"'
alias gall='echo "» git add ."; git add .'
alias gsync='echo "» git stash\n» git pull\n» git stash pop\n"; git stash && git pull && git stash pop'

alias gls='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias glds='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'

alias gph='echo "» git push heroku heroku:master"; git push heroku heroku:master'
alias gpstag='echo "» git push staging staging:master"; git push staging staging:master'
alias gpprod='echo "» git push production production:master"; git push production production:master'

if [[ $OS == 'OSX' ]]; then
  # GIT
  if command -v brew &>/dev/null
  then
    if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then 
      source `brew --prefix`/etc/bash_completion.d/git-completion.bash
    fi
  fi
# else
  # LINUX
fi
