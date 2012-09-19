# alias tt='tmux'
alias t='tmux'
alias tt-kill='t kill-server'
alias t-a='t attach-session -t $@'

function tt() {
  # var for session name (to avoid repeated occurences)
  # sn=$RANDOM
  sn=`echo ${PWD##*/}`

  # This will also be the default cwd for new windows created
  t new-session -d -s "$sn" 'reattach-to-user-namespace -l bash vim .'

  # New window
  t new-window -t "$sn:2" 'reattach-to-user-namespace -l bash'

  # Select window #1 and attach to the session
  t select-window -t "$sn:1"
  t -2 attach-session -t "$sn"
}

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color
