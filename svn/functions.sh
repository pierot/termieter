svn-add-all() {
  svn st | grep "^?" | awk '{$1=""; print $0}' | while read f; do svn add "$f"; done
}

svn-delete-all() {
  svn st | grep '^\!' | sed 's/! *//' | xargs -I% svn rm %
}

alias svn-status-all='~/.termieter/svn/functions/svnstatus.py $@'

alias svn-up-all='~/.termieter/svn/functions/svnup.py $@'
alias svn-update-all='svn-up-all'
