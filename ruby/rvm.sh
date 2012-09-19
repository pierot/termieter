if [ -s "$HOME/.rvm/scripts/rvm" ]; then
  . "$HOME/.rvm/scripts/rvm"

  if groups | grep -q rvm; then
    source '/usr/local/lib/rvm'
  fi
fi

