# Termieter Minimal ZSH Theme
# Clean, fast, no dependencies - works on any system

# Colors
local BLUE='%F{blue}'
local GREEN='%F{green}'
local RED='%F{red}'
local YELLOW='%F{yellow}'
local MAGENTA='%F{magenta}'
local CYAN='%F{cyan}'
local WHITE='%F{white}'
local RESET='%f'

# Git status indicators
local GIT_BRANCH="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
local GIT_DIRTY="$(git status --porcelain 2>/dev/null | grep -q . && echo '*' || echo '')"

# Prompt components
local USER_COLOR=$BLUE
local HOST_COLOR=$GREEN
local PATH_COLOR=$CYAN
local TIME_COLOR=$WHITE

# Build prompt
PROMPT=''

# Add user@host if not default user
if [[ $USER != "root" && $USER != "$DEFAULT_USER" ]]; then
  PROMPT+="$USER_COLOR%n$RESET@"
fi

# Add hostname
PROMPT+="$HOST_COLOR%m$RESET "

# Add current directory
PROMPT+="$PATH_COLOR%~$RESET "

# Add git info if in git repo
if [[ -n $GIT_BRANCH ]]; then
  PROMPT+="$MAGENTA($GIT_BRANCH$GIT_DIRTY)$RESET "
fi

# Add time
PROMPT+="$TIME_COLOR%*$RESET"

# Right prompt with exit status
RPROMPT=''
if [[ $? -ne 0 ]]; then
  RPROMPT+="$RED✗$RESET"
else
  RPROMPT+="$GREEN✓$RESET"
fi

# Reset color
PROMPT+="$RESET "
RPROMPT+="$RESET "
