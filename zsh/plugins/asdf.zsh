# asdf.zsh
# Lightweight asdf integration

# Only load if asdf is available
(( ! $+commands[asdf] )) && return

export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"

# Add shims to the front of the path, removing if already present
path=("$ASDF_DATA_DIR/shims" ${path:#$ASDF_DATA_DIR/shims})

# Setup completions if available
if [[ -f "$ASDF_DATA_DIR/completions/_asdf" ]]; then
  fpath=("$ASDF_DATA_DIR/completions" $fpath)
fi
