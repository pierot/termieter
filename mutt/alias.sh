if [[ `uname` == 'Darwin' ]]; then
  alias mutt='cd ~/Downloads && mutt'
else
  alias mutt='mkdir -p ~/tmp && cd ~/tmp && mutt'
fi
