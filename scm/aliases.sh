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

alias svn-status-all="$TRM/scm/functions/svnstatus.py $@"
alias svn-up-all="$TRM/scm/functions/svnup.py $@"
alias svn-update-all='svn-up-all'

# GIT
alias gst='echoo "git status"; git status'
alias gp='echoo "git push"; git push "$@"'
alias gpl='echoo "git pull"; git pull "$@"'
alias gcm='echoo "git commit -m"; git commit -m "$@"'
alias gsync='echoo "git stash"; echoo "git pull"; echoo "git stash pop"; git stash && git pull && git stash pop'
alias gpp='echoo "git commit --allow-empty -m [deploy: production]; git push"; git commit --allow-empty -m "[deploy: production]"; git push'

alias gls='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias glds='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
