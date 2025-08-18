export ICLOUD="~/Library/Mobile\ Documents/com~apple~CloudDocs"

if [ -d "`eval echo ${ICLOUD//>}`" ]; then
  alias icloud="cd $ICLOUD"
  alias repos="cd $ICLOUD/Work/repos/"
  alias dev="cd $ICLOUD/Work/devel/"
fi

export DROPBOX="$HOME/Dropbox"

# if [ -d $DROPBOX ]; then
# fi

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

###################################

alias ap='ansible-playbook'
