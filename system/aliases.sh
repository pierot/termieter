alias termieter='cd ~/.termieter'
alias termietere='cd ~/.termieter; vim .'
alias vime='cd ~/.vim; vim .'
alias reload!='. ~/.bash_profile'

# paths
################################################################################################################

alias repos='cd ~/Dropbox/Private/work/repos/'
alias dev='cd ~/Documents/Devel/'
alias clients='cd ~/Dropbox/Private/work/clients/'
alias projects='cd ~/Documents/Projects/'

################################################################################################################

alias ..='cd ..'
alias ...='cd .. ; cd ..'

alias ls='ls $LS_OPT -Gl' # long list, excludes dot files
alias ll='ls $LS_OPT -Gla' # long list all, includes dot files

alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'" # Get readable list of network IPs
alias ip='dig +short myip.opendns.com @resolver1.opendns.com' # my ip
alias flushdns='echo "» dscacheutil -flushcache"; dscacheutil -flushcache' # Flush DNS cache

alias gzip='echo "» gzip -9n"; gzip -9n' # set strongest compression level as ‘default’ for gzip
alias ping='echo "» pint -c 5"; ping -c 5' # ping 5 times ‘by default’

alias hidden-show='defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder'
alias hidden-hide='defaults write com.apple.finder AppleShowAllFiles -bool false; killall Finder'

alias cwd='pwd | pbcopy' # copy current working directory to clipboard

alias hosts='sudo vim /private/etc/hosts'

alias hist='history | grep "$@"'
alias hist-sort='history | cut -c 8- | sort | uniq -c | sort -rn'
