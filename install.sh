#!/usr/bin/env bash

_print() {
  COL_BLUE="\x1b[34;01m"
  COL_RESET="\x1b[39;49;00m"

  BLUE="\033[1;34m"
  WHITE="\033[1;37m"

  echo $BLUE"\n$1\n"$WHITE
} 

_print "Installing termieter files ***********************"

  cd ~

_print "Removing current termieter installation"

  rm -rf .termieter

_print "Check if 'git' exists"

  hash git 2>&- || { _print "I require git but it's not installed. Aborting."; exit 1; }

_print "Cloning into repo"

  git clone git://github.com/pierot/termieter.git ~/.termieter

_print "Backup all previous files"
  
  mkdir -p ~/.bash_backup

  _back_file() {
    if [ -f "~/$1" ]; then
    	mv "~/$1" "~/.bash_backup/$1"
    fi
  }

  _back_file ".bash_profile"
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

_print "Installation finished **************************\n"
