# Create a new directory and enter it
md() {
  mkdir -p "$@" && cd "$@"
}

# Copy your public ssh key to remote server for password-less login
# Usage: open-sesame 'tortuga'
function open-sesame () {
  cat ~/.ssh/id_rsa.pub | ssh $@ "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys";
}

# Helper :)
function listf () {
  cat "$HOME/.termieter/system/functions.sh"
}
