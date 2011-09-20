#!/usr/bin/env bash

wget -N --quiet https://raw.github.com/pierot/server-installer/master/lib.sh; . ./lib.sh

_print "Installing termieter files ***********************"

  cd ~

_print "Removing current termieter installation"

  rm -rf .termieter

_print "Check if 'git' exists"

  GIT_INSTALLED=true

  hash git 2>&- || { _error "I require git but it's not installed!"; GIT_INSTALLED=false; }

  if ! $GIT_INSTALLED; then
    while true
    do
      read -p "Do you want me to install git? (sudo needed) [Y/N] " RESP

      case $RESP
        in
        [yY])
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

_print "Cloning into repo"

  if $GIT_INSTALLED; then
    git clone git://github.com/pierot/termieter.git ~/.termieter
  fi

  if [ ! -d "./.termieter" ]; then
    _error "Termieter doesn't seem to be installed correctly. Aborting"

    exit 1
  else
    _print "Backup all previous files"
      
      mkdir -p ~/.bash_backup

      _back_file() {
        [ -e "$1" ] && mv "$1" ".bash_backup/$1" 
      }

      _back_file ".bash_profile"
      _back_file ".profile"
      _back_file ".bashrc"
      _back_file ".gitconfig"
      _back_file ".screenrc"

    _print "Symlinking all files"

      _print "\t.bash_profile"

        ln -sf ~/.termieter/bash_profile ~/.bash_profile

      _print "\t.gitconfig"

        ln -sf ~/.termieter/gitconfig ~/.gitconfig

      _print "\t.screenrc"

        ln -sf ~/.termieter/screenrc ~/.screenrc

      _print "\t.irbrc"

        ln -sf ~/.termieter/irbrc ~/.irbrc

    _print "Installation finished **************************"
  fi
