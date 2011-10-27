#!/usr/bin/env bash

wget -N --quiet https://raw.github.com/pierot/server-installer/master/lib.sh; . ./lib.sh

############################################################################### 
 
install_dir='.termieter'     
 
############################################################################### 
 
_usage() {                 
  _print "                 
 
Usage:              install.sh -d ['.termieter'] 
 
Remote Usage:       bash <( curl -s https://raw.github.com/pierot/termieter/master/install.sh ) [-d '.termieter'] 
 
Options: 
  
  -h                Show this message 
  -d '.termieter'   Install directory (always in $HOME folder)
  " 
 
  exit 0 
}  
 
############################################################################### 
 
while getopts :hd: opt; do  
  case $opt in 
    h) 
      _usage 
      ;; 
    d) 
      install_dir="$HOME/$OPTARG"
      ;; 
    *) 
      _error "Invalid option received" 
 
      _usage 

      exit 0
      ;;
  esac 
done

############################################################################### 

cd ~

_print "Removing current termieter installation"

rm -rf "$install_dir"

GIT_INSTALLED=true

hash git 2>&- || { _error "I require git but it's not installed!"; GIT_INSTALLED=false; }

if ! $GIT_INSTALLED; then
  while true
  do
    read -p "Do you want me to install git? (sudo needed) [Y/N] " RESP

    case $RESP
      in
      [yY])
        _check_root
        _system_installs_install 'git'

        GIT_INSTALLED=true
        break
        ;;
      [nN])
        break
        ;;
      *)
        echo "Please enter Y or N"
    esac
  done
fi

if $GIT_INSTALLED; then
  git clone git://github.com/pierot/termieter.git "$install_dir"
fi

if [ ! -d "$install_dir" ]; then
  _error "Termieter doesn't seem to be installed correctly. Aborting"

  exit 1
else
  mkdir -p ~/.bash_backup

  _back_install() {
    _print "Installing $1"

    if [ ! -n "$1" ]; then
      _error "Error in install script. Aborting"

      exit 1
    fi

    if [ -f "$HOME/.$1" ]; then
      mv "$HOME/.$1" "$HOME/.bash_backup/.$1" 
    fi

    if [ -f "$install_dir/symlinks/$1" ]; then
      if [ -n "$2" ]; then
        ln -sf "$install_dir/symlinks/$1" "$HOME/.$2"
      else
        ln -sf "$install_dir/symlinks/$1" "$HOME/.$1"
      fi
    fi
  }

  for sym_file in "$install_dir/symlinks/*.*"
  do
    _back_install "$sym_file"
    # _back_install "bash_profile"
    # _back_install "profile"
    # _back_install "bashrc"
    # _back_install "gemrc"
    # _back_install "gitconfig"
    # _back_install "gitignore"
    # _back_install "gvimrc.local"
    # _back_install "irbrc"
    # _back_install "screenrc"
    # _back_install "vimrc.local"
  done

  _print "Installation finished"
fi

_cleanup_lib
