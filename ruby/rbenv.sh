if [ -s "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"

  eval "$(rbenv init -)"
elif [ -s "/usr/local/rbenv/bin" ]; then
  export PATH="/usr/local/rbenv/bin:$PATH"

  eval "$(rbenv init -)"
fi
