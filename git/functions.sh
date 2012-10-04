if [[ `uname` == 'Darwin' ]]; then

  # OSX

  if command -v brew &>/dev/null
  then
    if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then 
      source `brew --prefix`/etc/bash_completion.d/git-completion.bash
    fi
  fi

else

  :# LINUX


fi
