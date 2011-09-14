#!/usr/bin/env bash

_print() {
  COL_BLUE="\x1b[34;01m"
  COL_RESET="\x1b[39;49;00m"

  printf $COL_BLUE"\n$1\n"$COL_RESET
} 

_print "Installing termieter files ***********************"

  cd ~

_print "Removing current installation"

  rm -rf .termieter

_print "Check if 'git' exists"

  hash git 2>&- || { _print "I require git but it's not installed. Aborting."; exit 1; }

_print "Cloning into repo"

  git clone git://github.com/pierot/termieter.git ~/.termieter

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
