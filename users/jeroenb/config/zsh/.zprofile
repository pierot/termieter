# Start X
if [[ "$OSTYPE" == "linux-gnu"* ]] &&  [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	startx
fi

# Rupa z
. $HOME/.termieter/users/jeroenb/bin/z.sh
