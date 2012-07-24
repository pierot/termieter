# alias tt='tmux'
alias tt-kill='tmux kill-server'

function tt() {
  # var for session name (to avoid repeated occurences)
  sn=$RANDOM

  # This will also be the default cwd for new windows created
  tmux new-session -d -s "$sn-base" 'vim .'

  # New window
  # tmux new-window -t "$sn:2" -n 'vim' 'vim .'
  tmux new-window -t "$sn:2" -n 'dir'

  # Select window #1 and attach to the session
  tmux select-window -t "$sn:1"
  tmux -2 attach-session -t "$sn-base"
}

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color
