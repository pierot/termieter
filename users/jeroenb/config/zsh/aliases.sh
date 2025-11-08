#!/bin/zsh

# neomutt
if have neomutt; then
  alias mutt="neomutt"
  alias m="neomutt"
fi

if have nvim; then
  alias v="nvim"
  alias vim="nvim"
  alias vi="nvim"
  alias vimdiff='nvim -d'
  alias vimd="cd ~/.config/nvim"
  alias vime="vim ~/.config/nvim"
fi

if have bat; then
  alias cat="bat"
fi

if have pnpm; then
  alias npm="pnpm"
fi

alias dev="cd $HOME/Work/"
alias db="cd $DROPBOX"
alias invoicing="cd $IAMJACK/Income"
alias iamjack="cd $IAMJACK"
alias jj="cd $HOME/Work/jackjoe"
alias gjj="cd $HOME/Work/jackjoe"
alias gj="cd $HOME/Work/jackjoe/justified"
alias gd="cd $HOME/Downloads"
alias gD="cd $HOME/Desktop"
alias gt="cd $HOME/.termieter"
alias gc="cd $HOME/.config"
alias gtu="cd $HOME/.termieter/users/jeroenb"
alias gv="cd $HOME/.termieter/users/jeroenb/config/nvim"
alias vime="cd $HOME/.termieter/users/jeroenb/config/nvim; nvim ."
alias termieteru="cd $HOME/.termieter/users/jeroenb"
alias gdb="cd $DROPBOX"
alias tss="sudo tailscale status"
alias tsj="sudo tailscale switch justified.be"
alias tsjj="sudo tailscale switch jackjoe"
alias tsa="sudo tailscale switch accurat"
#alias ssh="kitty +kitten ssh"
alias df="df -h"
alias free="free -m"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -o'
alias jctl="journalctl -p 3 -xb"               # get error messages from journalctl
alias m='neomutt'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias xmonadconf="vim ~/.config/xmonad/xmonad.hs"
alias bc="bc -l"

# utils
alias grep="grep --color=auto"
alias pacman="sudo pacman --color=auto"
alias diff="diff --color=auto"
alias ip="ip -color=auto"
alias perfmode="cat /sys/firmware/acpi/platform_profile"

# Git stuff
alias gap='git add -p'
alias gst='git status'
alias ga="git add $1"
alias gb="git branch"
alias gba="git branch --all"
alias gdoc='git add . && gcmm docs: add documentation'
alias gmerge='git add . && gcmm chore: merge'
alias gcompile='git add . && gcmm chore: compile'
alias gbump='git add . && gcmm chore: bump versions'
alias gcleanup='git add . && gcmm chore: cleanup'
alias gfix='git add . && gcmm fix'
alias gammend='git commit --amend --no-edit'
alias glog="git log --oneline --graph --decorate --all"

alias lynx='lynx -cfg ~/.config/lynx/lynx.cfg'

# Justified related
alias jh='for file in ./*.svg; do convert -density 1200 -resize 2400x580 $file `basename $file .svg`.jpg; done'
alias jf='for file in ./*.svg; do convert -density 2400 -resize 4800x236 $file `basename $file .svg`.jpg; done'
alias mdp='make deploy_production'
alias mdph='make deploy_production_hotfix'
alias mrmg='make run_miss_grump'
alias mrdd='make run_docdropper'

alias bfg='java -jar ~/.termieter/users/jeroenb/bin/bfg.jar'

# Upgrade Portainer
alias upgrade_portainer='sudo docker stop portainer && sudo docker rm portainer && sudo docker pull portainer/portainer-ce:latest && sudo docker run -d -p 8000:8000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest'
alias fixkb='xset r rate 200 90 && setxkbmap -option compose:paus && setxkbmap -option caps:escape_shift_capslock'
alias kbfix='xset r rate 200 90 && setxkbmap -option compose:paus && setxkbmap -option caps:escape_shift_capslock'

# my external ip
alias myip='curl -s https://ipinfo.io/ip'
alias macarchius='echo d8:bb:c1:8d:72:7c'
alias macdaddy=macarchius
alias wakemeupbeforeyougogo='wol -p 9 d8:bb:c1:8d:72:7c'

# because
alias ivat='BE0568678435'
alias vati='BE0568678435'
alias btwiamjack='BE0568678435'
alias btw='BE0568678435'

unalias claude # set in zsh/common.sh
