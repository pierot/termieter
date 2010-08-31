# Profile settings, paths, aliases, belongs to machine

################################################################################################################
# ALIASES
alias _clientrepos="cd ~/Documents/Dropbox/Private/work/Client\ Repos/"
alias _dev="cd ~/Documents/Dropbox/Private/work/Development/"
alias _clients="cd ~/Documents/Dropbox/Private/work/Clients/"
alias _projects="cd ~/Documents/Projects/"

alias start_mongo="mongod run --config /usr/local/Cellar/mongodb/1.6.0-x86_64/mongod.conf --rest"

alias show_hidden="defaults write com.apple.finder AppleShowAllFiles -bool true"
alias hide_hidden="defaults write com.apple.finder AppleShowAllFiles -bool false"

################################################################################################################
# PATH
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}" # Setting PATH for MacPython 2.6

export PATH

################################################################################################################
# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
	
################################################################################################################