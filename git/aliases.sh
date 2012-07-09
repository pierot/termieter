alias gst='echo "» git status"; git status'
alias gp='echo "» git push"; git push "$@"'
alias gph='echo "» git push heroku heroku:master"; git push heroku heroku:master'
alias gcam='echo "» git commit -a -m"; git commit -a -m "$@"'
alias gall='echo "» git add ."; git add .'
alias gca='echo "» git commit -a"; git commit -a'

alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'

alias gpstag='echo "» git push staging staging:master"; git push staging staging:master'
alias gpprod='echo "» git push production production:master"; git push production production:master'
