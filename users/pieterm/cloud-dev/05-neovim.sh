#!/usr/bin/env bash
# 05-neovim — Neovim from official release tarball (telescope needs 0.11+)

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

SECTION_ID="05-neovim"
section_done "$SECTION_ID" && exit 0

banner "Neovim (official tarball)" "📝"

# `stable` always redirects to the latest stable release on GitHub.
# Override with NVIM_VERSION=v0.11.4 for a pinned tag.
NVIM_VERSION="${NVIM_VERSION:-stable}"
NVIM_PREFIX="$HOME/.local/share/nvim-tarball"
NVIM_EXTRACT="$NVIM_PREFIX/nvim-linux-x86_64"
NVIM_BIN="$NVIM_EXTRACT/bin/nvim"
NVIM_LINK="$HOME/.local/bin/nvim"
NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"

STEP_TOTAL=3

# --- step 1: download + extract ---
step "Download Neovim ${NVIM_VERSION}"
if [[ -x "$NVIM_BIN" ]] && [[ "${FORCE:-0}" == 0 ]]; then
  skip "Already extracted at $NVIM_BIN ($("$NVIM_BIN" --version | head -1))"
else
  if [[ "$DRY_RUN" == 1 ]]; then
    info "(dry-run) would download $NVIM_URL → $NVIM_PREFIX"
  else
    mkdir -p "$NVIM_PREFIX"
    tmp=$(mktemp --suffix=.tar.gz)
    if retry curl -fsSL "$NVIM_URL" -o "$tmp"; then
      # Wipe any previous extract so symlinks inside don't get stale
      rm -rf "$NVIM_EXTRACT"
      spin "Extracting" tar -xzf "$tmp" -C "$NVIM_PREFIX"
      rm -f "$tmp"
      if [[ ! -x "$NVIM_BIN" ]]; then
        fail "Expected binary missing after extract: $NVIM_BIN"
        exit 1
      fi
      ok "Extracted $("$NVIM_BIN" --version | head -1) → $NVIM_EXTRACT"
    else
      rm -f "$tmp"
      fail "Could not download $NVIM_URL"
      exit 1
    fi
  fi
fi

# --- step 2: symlink into ~/.local/bin ---
step "Link nvim into ~/.local/bin"
mkdir -p "$HOME/.local/bin"
if [[ "$DRY_RUN" == 1 ]]; then
  info "(dry-run) would link: $NVIM_LINK → $NVIM_BIN"
else
  ln -sf "$NVIM_BIN" "$NVIM_LINK"
  ok "Linked: $NVIM_LINK → $NVIM_BIN"
fi

# --- step 3: verify + PATH guidance ---
step "Verify nvim"
if has_cmd nvim; then
  ok "nvim on PATH: $(nvim --version | head -1)"
elif [[ -x "$NVIM_BIN" ]]; then
  ok "nvim installed at $NVIM_BIN ($("$NVIM_BIN" --version | head -1))"
  warn "Add ~/.local/bin to your PATH:"
  log "    ${DIM}export PATH=\"\$HOME/.local/bin:\$PATH\"${RESET}"
else
  fail "Neovim install did not produce a binary"
  exit 1
fi

mark_done "$SECTION_ID"
ok "Section complete: $SECTION_ID"
