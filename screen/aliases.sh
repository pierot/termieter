alias screen='export SCREENPWD=$(pwd); /usr/bin/screen -U -T $TERM'
alias s='export SCREENPWD=$(pwd); /usr/bin/screen -U -T $TERM'

case "$TERM" in 
  'screen')
     cd $SCREENPWD
     ;; 
esac
