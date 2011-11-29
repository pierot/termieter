alias gst='echo "» git status"; git status'
alias gp='echo "» git push"; git push "$@"'
alias gcam='echo "» git commit -a -m"; git commit -a -m "$@"'
alias gca='echo "» git commit -a"; git commit -a'

alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
