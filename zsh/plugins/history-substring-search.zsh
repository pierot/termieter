# history-substring-search.zsh
# Extracted from oh-my-zsh for standalone use
# Source: https://github.com/zsh-users/zsh-history-substring-search

# Load the actual plugin
if [[ -f "$TRM/zsh/oh-my-zsh/plugins/history-substring-search/history-substring-search.zsh" ]]; then
  source "$TRM/zsh/oh-my-zsh/plugins/history-substring-search/history-substring-search.zsh"

  # Bind terminal-specific up and down keys
  if [[ -n "$terminfo[kcuu1]" ]]; then
    bindkey -M emacs "$terminfo[kcuu1]" history-substring-search-up
    bindkey -M viins "$terminfo[kcuu1]" history-substring-search-up
  fi
  if [[ -n "$terminfo[kcud1]" ]]; then
    bindkey -M emacs "$terminfo[kcud1]" history-substring-search-down
    bindkey -M viins "$terminfo[kcud1]" history-substring-search-down
  fi
fi
