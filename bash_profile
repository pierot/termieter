# load bashrc and profile
for file in rc_aliases rc_functions rc_exports rc_scripts rc_bashrc 'scripts/z.sh' ; do
  file="$HOME/.termieter/$file"
  [ -e "$file" ] && source "$file"
done
