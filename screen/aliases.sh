alias screen='export SCREENPWD=$(pwd); /usr/bin/screen -U'

case "$TERM" in 
    'screen')
         cd $SCREENPWD
         ;; 
esac
