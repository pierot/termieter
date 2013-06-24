have() {
  type "$1" &> /dev/null
}

# NODEJS
export NODE_PATH="/usr/local/lib/node_modules"

if have go; then
  function setup_gopaths() {
    local GOPATH=`which go`
    local GODIR=`dirname $GOPATH`
    local GOPATH_BREW_RELATIVE=`readlink $GOPATH`
    local GOPATH_BREW=`dirname $GOPATH_BREW_RELATIVE`

    export GOROOT=`cd $GODIR; cd $GOPATH_BREW/..; pwd`
  }

  setup_gopaths
fi

# PYTHON
if [ -f '/usr/local/share/python/virtualenvwrapper.sh' ]; then
  if [ `id -u` != '0' ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    export VIRTUALENV_USE_DISTRIBUTE=1        # <-- Always use pip/distribute
    export WORKON_HOME=~/.virtualenvs       # <-- Where all virtualenvs will be stored

    source /usr/local/share/python/virtualenvwrapper.sh

    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true
  fi
fi

# RUBY
if [[ $OS == 'OSX' ]]; then
  export RACK_ENV='development'
  export RAILS_ENV='development'
  export PORT='3000'
# else
  # LINUX
fi

# RBENV
if have rbenv; then
  eval "$(rbenv init -)"
else
  if [ -s "~/.rbenv/bin" ]; then
    export PATH="~/.rbenv/bin:$PATH"

    eval "$(rbenv init -)"
  elif [ -s "/usr/local/rbenv/bin" ]; then
    export PATH="/usr/local/rbenv/bin:$PATH"

    eval "$(rbenv init -)"
  fi
fi

# RVM
if [ -s "~/.rvm/scripts/rvm" ]; then
  . "~/.rvm/scripts/rvm"

  if groups | grep -q rvm; then
    source '/usr/local/lib/rvm'
  fi
fi
