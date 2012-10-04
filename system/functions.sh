# Create a new directory and enter it
md() {
  mkdir -p "$@" && cd "$@"
}

# Copy your public ssh key to remote server for password-less login
# Usage: ssh-sesame 'tortuga'
function ssh-sesame () {
  cat "$HOME/.ssh/id_rsa.pub" | ssh $@ "mkdir -p $HOME/.ssh && cat >> $HOME/.ssh/authorized_keys";
}

# Copy public ssh key
function ssh-public () {
  echo "» cat $HOME/.ssh/id_rsa.pub | pbcopy"

  cat "$HOME/.ssh/id_rsa.pub" | pbcopy
}

function host-dropbox() {
  ln -s `pwd` "$HOME/Dropbox/Public/www/projects"
}

# Clear temp files for a faster Terminal
function fasterfaster() {
  sudo rm -rf /private/var/log/asl/*
  sudo rm -rf /var/mail/*
}

# Remove spaces and replace by a dash
function remove-spaces() {
  for file in *
  do 
    mv "$file" "${file// /-}"
  done
}

# Remove underscore and replace by a dash
function remove-underscore() {
  for file in *
  do 
    mv "$file" "${file//_/-}"
  done
}

# Helper :)
function listf () {
  cat "$TRM/system/functions.sh"
}

if [[ `uname` == 'Darwin' ]]; then

  # OSX

  # Fix font caches
  function fix-fonts () {
    echo "» atsutil databases -removeUser; atsutil server -shutdown; atsutil server -ping"

    atsutil databases -removeUser
    atsutil server -shutdown
    atsutil server -ping
  }

else
  
  :# LINUX


fi
