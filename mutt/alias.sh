if [[ $OS == 'OSX' ]]; then
  alias mutt='cd ~/Downloads && mutt'
else
  alias mutt='mkdir -p ~/tmp && cd ~/tmp && mutt'
fi
