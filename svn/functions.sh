svn-add-all() {
  svn st | grep "^?" | awk '{$1=""; print $0}' | while read f; do svn add "$f"; done
}

alias svn-status-all='~/.termieter/svn/functions/svnstatus.py $@'
alias svn-up-all='~/.termieter/svn/functions/svnup.py $@'
