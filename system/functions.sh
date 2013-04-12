extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
     esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Whether or not we have a command
# http://dotfiles.org/~steve/.bashrc
have() {
  type "$1" &> /dev/null
}

# Filter through running processes
psgrep() {
  ps aux | \grep -e "$@" | \grep -v "grep -e $@"
}

# Sort the "du" output and use human-readable units.
# https://github.com/janmoesen/tilde/blob/master/.bash/commands
duh() {
  du -sk ${@:-*} | sort -n | while read size fname; do
    for unit in KiB MiB GiB TiB PiB EiB ZiB YiB; do
      if [ "$size" -lt 1024 ]; then
        echo -e "${size} ${unit}\t${fname}"
        break
      fi
      size=$((size/1024))
    done
  done
}

###############################################################################
# SSH

# Copy your public ssh key to remote server for password-less login
# Usage: ssh-sesame 'tortuga'
function ssh-sesame() {
  cat "~/.ssh/id_rsa.pub" | ssh $@ "mkdir -p .ssh && cat >> .ssh/authorized_keys";
}

###############################################################################
# SYSTEM

# Clear temp files for a faster Terminal
function fasterfaster() {
  sudo rm -rf /private/var/log/asl/*
  sudo rm -rf /var/mail/*
}

###############################################################################
# RENAMING

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

# List all files interacting with ipv4-6 ports
function list-files-ports() {
  echoo "lsof -i"

  lsof -i
}

function find-todos() {
  find . -exec grep -Hin TODO {} \;
}

###############################################################################
# Helper :)

function listf() {
  cat "$TRM/system/functions.sh"
}

###############################################################################
# OS

if [[ $OS == 'OSX' ]]; then
  # Fix font caches
  function fix-fonts() {
    echoo "atsutil databases -removeUser; atsutil server -shutdown; atsutil server -ping"

    atsutil databases -removeUser
    atsutil server -shutdown
    atsutil server -ping
  }
else
  function list-services() {
    chkconfig --list | grep '3:on'
  }

  function active-connections() {
    netstat -tulpn
  }

  function iptables-clear() {
    iptables -F
    iptables -X
    iptables -t nat -F
    iptables -t nat -X
    iptables -t mangle -F
    iptables -t mangle -X
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -P FORWARD ACCEPT
  }
fi
