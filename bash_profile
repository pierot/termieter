# load bashrc and profile
for file in rc_aliases rc_functions rc_exports rc_scripts rc_bashrc 'scripts/z.sh' ; do
  file="$HOME/.termieter/$file"
  [ -e "$file" ] && source "$file"
done

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
# 
# if groups | grep -q rvm; then
#   source '/usr/local/lib/rvm'
# fi
# 
# [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion # for RVM completion
# 
# # Git completion
# if command -v brew &>/dev/null
# then
#   if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then 
#     source `brew --prefix`/etc/bash_completion.d/git-completion.bash
#   fi
# fi
