# TMUX
alias t='tmux'
alias tk='tmux kill-server'
alias ta='tmux attach-session -t $@'
alias tl='tmux ls'

# function tt-mail() {
#   tmux has-session -t mutt 2>/dev/null
#   if [ "$?" -eq 1 ] ; then
#     tmux new-session -d -s "mutt" "reattach-to-user-namespace -l $SHELL"
#   fi
#   # tmux attach-session -t "mutt"
# }

function tt() {
  tt-mail

  # var for session name (to avoid repeated occurences)
  sn=`echo ${PWD##*/}`

  # This will also be the default cwd for new windows created
  tmux new-session -d -s "$sn" "reattach-to-user-namespace -l vim ."

  # New window
  tmux new-window -t "$sn:2" "reattach-to-user-namespace -l $SHELL"

  # Select window #1 and attach to the session
  tmux select-window -t "$sn:1"
  tmux -2 attach-session -t "$sn"
}

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color

# SCREEN
alias screen='export SCREENPWD=$(pwd); /usr/bin/screen -U -T $TERM'
alias s='export SCREENPWD=$(pwd); /usr/bin/screen -U -T $TERM'

case "$TERM" in
  'screen')
     cd $SCREENPWD
     ;;
esac
