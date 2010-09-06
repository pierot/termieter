# Profile settings, paths, aliases, belongs to machine

# ALIASES
################################################################################################################

alias _clientrepos="cd ~/Documents/Dropbox/Private/work/Client\ Repos/"
alias _dev="cd ~/Documents/Dropbox/Private/work/Development/"
alias _clients="cd ~/Documents/Dropbox/Private/work/Clients/"
alias _projects="cd ~/Documents/Projects/"

alias start_mongo="mongod run --config /usr/local/Cellar/mongodb/1.6.0-x86_64/mongod.conf --rest"

# PATH
################################################################################################################

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}" # Setting PATH for MacPython 2.6

export PATH

# RVM
################################################################################################################

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# WORKING ENVIRONMENT	
################################################################################################################

function init_env() {
    COMMANDS=( "start_mongo" "_dev;clear" "_clientrepos;clear" )
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