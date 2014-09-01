#!/bin/bash
# -

echo -n "Retmux Start" | logger

# echo $HOME | logger
#
# python -c "import os; import sys; sys.stdout.write(os.getenv('HOME'))" | logger

whoami | logger

/usr/local/bin/tmux list-sessions | logger
# su pieterm -c '/usr/local/bin/tmux list-sessions' | logger

# sudo -u pieterm /usr/local/bin/retmux -b
# /usr/local/bin/retmux -b | logger

echo -n "Retmux Done" | logger
echo -n " " | logger

# while read line
# do
#   retmux -b '$line';
# done < <(tmux ls | awk '{print $1}' | awk -F\: '{print $1}')
