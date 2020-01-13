#!/bin/bash
# setup tmux like an IDE
# Created:      2019-12-14
# Last updated: 2019-12-14
function ide() {
  tmux split-window -h -p 30 'source .env && mix deps.get && make run'
  tmux split-window -v -p 50
  tmux split-window -v -p 60
  tmux select-pane -L
  nvim
}
