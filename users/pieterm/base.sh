export ICLOUD="~/Library/Mobile\ Documents/com~apple~CloudDocs"

# if [ -d "~/Library/Mobile\ Documents/com\~apple\~CloudDocs" ]; then
  alias icloud="cd $ICLOUD"
  alias repos="cd $ICLOUD/Work/repos/"
  alias dev="cd $ICLOUD/Work/devel/"
# fi

export DROPBOX="~/Dropbox"

if [ -d $DROPBOX ]; then
fi

###################################

export PATH="/usr/local/opt/php@7.3/bin:$PATH"

###################################

alias ap='ansible-playbook'
