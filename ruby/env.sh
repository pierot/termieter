if [[ `uname` == 'Darwin' ]]; then
  export RACK_ENV='development'
  export RAILS_ENV='development'
  export PORT='3000'
fi
