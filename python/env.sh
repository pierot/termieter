if [ `id -u` != '0' ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  export VIRTUALENV_USE_DISTRIBUTE=1        # <-- Always use pip/distribute
  export WORKON_HOME=$HOME/.virtualenvs       # <-- Where all virtualenvs will be stored

  source /usr/local/share/python/virtualenvwrapper.sh

  export PIP_VIRTUALENV_BASE=$WORKON_HOME
  export PIP_RESPECT_VIRTUALENV=true
fi
