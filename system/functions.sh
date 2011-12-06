# function dev-cardigle () {
#   COMMANDS=( "clear;z frritt;clear;rails s thin" "clear;z frritt;mvim .;clear" "clear;z jules;clear" )
#   LENGTH=${#COMMANDS[@]}
#   COUNT=0
# 
#   for command in "${COMMANDS[@]}"
#     do
#       COUNT=$((COUNT+1))
#       osascript <<-EOF
#         tell application "Terminal"
#           activate
#           set window_id to id of first window whose frontmost is true
# 
#           do script "$command" in window id window_id of application "Terminal"
# 
#           if $COUNT < $LENGTH then
#             tell application "System Events"
#               keystroke "t" using {command down}
#             end tell
#           end if
#         end tell
#       EOF
#     done
# }

# Create a new directory and enter it
md() {
  mkdir -p "$@" && cd "$@"
}

# Trash a file from your Terminal
alias trash='mv "$@" ~/.Trash/'

# Copy your public ssh key to remote server for password-less login
# Usage: open-sesame 'tortuga'
function open-sesame () {
  cat ~/.ssh/id_rsa.pub | ssh $@ "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys";
}

# Clear temp files for a faster Terminal
alias fasterfaster='sudo rm -rf /private/var/log/asl/*; sudo rm -rf /var/mail/*'

# Remove spaces and replace by a dash
alias remove-spaces='for file in *; do mv "$file" "${file// /-}"; done'

# Helper :)
function listf () {
  echo "trash file-name"
  echo "open-sesame 'host'"
  echo "remove-spaces # execites in current folder"
  echo "fasterfaster"
}
