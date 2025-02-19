fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-rupa-SLASH-z )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-rupa-SLASH-z/z.sh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions/zsh-completions.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/editor )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/editor/editor.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/history )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/history/history.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/prompt )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/prompt/prompt.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/utility )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/utility/utility.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/completion )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/completion/completion.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-romkatv-SLASH-powerlevel10k )
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-autosuggestions )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
if ! (( $+functions[zsh-defer] )); then
  fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-romkatv-SLASH-zsh-defer )
  source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-romkatv-SLASH-zsh-defer/zsh-defer.plugin.zsh
fi
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zdharma-continuum-SLASH-fast-syntax-highlighting )
zsh-defer source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zdharma-continuum-SLASH-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-Aloxaf-SLASH-fzf-tab )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-Aloxaf-SLASH-fzf-tab/fzf-tab.plugin.zsh
