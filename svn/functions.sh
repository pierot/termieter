svn-add-all() {
	svn st | grep "^?" | awk '{$1=""; print $0}' | while read f; do svn add "$f"; done
}

alias svn-status-all='~/.termieter/scripts/svnstatus.py $@'
alias svn-up-all='~/.termieter/scripts/svnup.py $@'
