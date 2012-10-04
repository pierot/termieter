if [[ `uname` == 'Darwin' ]]; then

  # OSX

  export RACK_ENV='development'
  export RAILS_ENV='development'
  export PORT='3000'
else

  :# LINUX


fi
