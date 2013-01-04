alias gst='echo "» git status"; git status'
alias gp='echo "» git push"; git push "$@"'
alias gcam='echo "» git commit -a -m"; git commit -a -m "$@"'
alias gall='echo "» git add ."; git add .'

alias gls='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias glds='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'

alias gph='echo "» git push heroku heroku:master"; git push heroku heroku:master'
alias gpstag='echo "» git push staging staging:master"; git push staging staging:master'
alias gpprod='echo "» git push production production:master"; git push production production:master'
