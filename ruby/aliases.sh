alias be='echo "» bundle exec"; bundle exec'
alias b='echo "» bundle"; bundle'
alias r='echo "» be rails"; be rails'

alias rt='echo "» be rails s thin"; be rails s thin'

alias f='echo "» be foreman start -p 3000"; be foreman start -p 3000'

alias c='echo "» be cap deploy"; be cap deploy'
alias cm='echo "» be cap deploy:migrations"; be cap deploy:migrations'

if [[ $OS == 'OSX' ]]; then
  export RACK_ENV='development'
  export RAILS_ENV='development'
  export PORT='3000'
# else
  # LINUX
fi
