# Create a new directory and enter it
md() {
  mkdir -p "$@" && cd "$@"
}

# Copy your public ssh key to remote server for password-less login
# Usage: open-sesame 'tortuga'
function open-sesame () {
  cat ~/.ssh/id_rsa.pub | ssh $@ "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys";
}

# convert currency from command line
function curr () {
  if [ $1 == 'all' ]; then
    wget -qO- "http://hints.macworld.com/dlfiles/curr_units.txt"; echo ""
  else
    for i in $3
    do
      wget -qO- "http://www.google.com/finance/converter?a=$1&from=$2&to=$i&hl=en" |  sed '/res/!d;s/<[^>]*>//g';
    done
  fi
}

# Helper :)
function listf () {
  cat "$HOME/.termieter/system/functions.sh"
}
