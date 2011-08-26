# Profile settings, paths, aliases, belongs to machine

# ALIASES
################################################################################################################

alias termieter='cd ~/.termieter'
alias termietere='vim ~/.termieter'
alias termieterc='source ~/.termieter/profile ~/.termieter/bashrc'

alias r='rails'

# ALIASES PATH
################################################################################################################

alias repos='cd ~/Dropbox/Private/work/repos/'
alias dev='cd ~/Documents/Devel/'
alias clients='cd ~/Dropbox/Private/work/clients/'
alias projects='cd ~/Documents/Projects/'

# ALIASES SERVERS
################################################################################################################

alias mongo-start='mongod run --config /usr/local/Cellar/mongodb/1.8.1-x86_64/mongod.conf --rest'

alias mysql-start='launchctl load /usr/local/Cellar/mysql/5.5.12/com.mysql.mysqld.plist'
alias mysql-stop='launchctl unload /usr/local/Cellar/mysql/5.5.12/com.mysql.mysqld.plist'
alias mysql-restart='mysql-stop | mysql-start'

alias postgresql-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias postgresql-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias posgresql-restart='postgresql-stop | postgresql-start'

alias apache-start='sudo apachectl start'
alias apache-restart='sudo apachectl restart'
alias apache-stop='sudo apachectl stop'

alias apache-vhosts='sudo vim /private/etc/apache2/extra/httpd-vhosts.conf'
alias apache-config='sudo vim /private/etc/apache2/httpd.conf'

# ALIASES SVN
################################################################################################################

alias svn-status-all='~/.termieter/scripts/svnstatus.py $@'
alias svn-up-all='~/.termieter/scripts/svnup.py $@'

svn-add-all() {
	svn st | grep "^?" | awk '{$1=""; print $0}' | while read f; do svn add "$f"; done
}

# ALIASES GIT
################################################################################################################

alias gst='git status'
alias gcam='git commit -a -m "$@"'
alias gca='git commit -a'

alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'

# PATH
################################################################################################################

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/usr/local/share/python:$PATH"

export PATH="$HOME/.termieter/scripts:$PATH" # Custom scripts 
# export PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}" # Setting PATH for MacPython 2.6

export PATH

# RACK ENV
################################################################################################################

export RACK_ENV='development'
export RAILS_ENV='development'
export PORT='3000'

# VARS
################################################################################################################

export VIM_APP_DIR='/Volumes/data/Users/pieterm/Applications/MacVim-7_3-53/'

# WORKING ENVIRONMENT	
################################################################################################################

function dev-cardigle () {
  COMMANDS=( "clear;z frritt;clear;rails s thin" "clear;z frritt;mvim .;clear" "clear;z jules;clear" )
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

################################################################################################################
# SCRIPTS
################################################################################################################

# Z
[[ -s $HOME/.termieter/scripts/z.sh ]] && source $HOME/.termieter/scripts/z.sh
