# Profile settings, paths, aliases, belongs to machine

# ALIASES
################################################################################################################

alias termieter='cd ~/.termieter'
alias termietere='mate ~/.termieter/bashrc ~/.termieter/profile'
alias termieterc='source ~/.termieter/profile ~/.termieter/bashrc'

# ALIASES PATH
################################################################################################################

alias repos='cd ~/Documents/Dropbox/Private/work/Repos/'
alias dev='cd ~/Documents/Dropbox/Private/work/Development/'
alias clients='cd ~/Documents/Dropbox/Private/work/Clients/'
alias projects='cd ~/Documents/Projects/'

# ALIASES SERVERS
################################################################################################################

alias mongo-start='mongod run --config /usr/local/Cellar/mongodb/1.6.3-x86_64/mongod.conf --rest'

alias mysql-start='launchctl load /usr/local/Cellar/mysql/5.1.54/com.mysql.mysqld.plist'
alias mysql-stop='launchctl unload /usr/local/Cellar/mysql/5.1.54/com.mysql.mysqld.plist'
alias mysql-restart='mysql-stop | mysql-start'

alias apache-start='sudo apachectl start'
alias apache-restart='sudo apachectl restart'
alias apache-stop='sudo apachectl stop'

alias apache-vhosts='mate /private/etc/apache2/extra/httpd-vhosts.conf'
alias apache-config='mate /private/etc/apache2/httpd.conf'

alias python-start='~/.termieter/scripts/python-serve-from-here.py b 8001'

# ALIASES SVN
################################################################################################################

alias svn-status-all='~/.termieter/scripts/svnstatus.py $@'

svn-add-all() {
	svn st | grep "^?" | awk '{$1=""; print $0}' | while read f; do svn add "$f"; done
}

# ALIASES GIT
################################################################################################################

alias gst='git status'
alias gcam='git commit -a -m "$@"'
alias gca='git commit -a'

alias gpom='git push origin master'
alias gpod='git push origin develop'
alias gpos='git push origin staging'

alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'

alias gdocs='open "http://people.gnome.org/~federico/misc/git-cheat-sheet.txt" | open "http://about.digg.com/blog/10-useful-git-commands" | open "http://andyjeffries.co.uk/articles/25-tips-for-intermediate-git-users"'

# GIT COMPLETION
################################################################################################################

[[ -s $HOME/.termieter/scripts/git-completion.sh ]] && source $HOME/.termieter/scripts/git-completion.sh

# PATH
################################################################################################################

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}" # Setting PATH for MacPython 2.6

export PATH

# RVM
################################################################################################################

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# RACK ENV
################################################################################################################

export RACK_ENV='development'

# WORKING ENVIRONMENT	
################################################################################################################

function dev-cardigle () {
  COMMANDS=( "clear;z 2010-cardigle;clear;rails s" "clear;z 2010-cardigle;mate .;clear" "clear;z jules;clear" )
	LENGTH=${#COMMANDS[@]}
	COUNT=0
	
	for command in "${COMMANDS[@]}"
		do
			COUNT=$((COUNT+1))

			osascript <<-EOF
		 		tell application "Terminal"
					activate
					set window_id to id of first window whose frontmost is true

					do script "$command" in window id window_id of application "Terminal"
					 
					if $COUNT < $LENGTH then
						tell application "System Events"
							keystroke "t" using {command down}
						end tell
					end if
				end tell
			EOF
			
		done
}

# Z
################################################################################################################

[[ -s $HOME/.termieter/scripts/z.sh ]] && source $HOME/.termieter/scripts/z.sh
