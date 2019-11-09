#!/usr/bin/env bash

echo "HERE!!!"
test -f ~/.tmux.conf.local && tmux source-file ~/.tmux.conf.local
