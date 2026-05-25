#!/usr/bin/env bash
# 00-bootstrap — apt packages and base CLI tools

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

SECTION_ID="00-bootstrap"
section_done "$SECTION_ID" && exit 0

banner "Bootstrap: apt packages & base tools" "📦"

STEP_TOTAL=4

# --- step 1: apt update ---
step "apt-get update"
if [[ "$DRY_RUN" == 1 ]]; then
  info "(dry-run) would run: sudo apt-get update -qq"
else
  retry sudo apt-get update -qq
  ok "Package index refreshed"
fi

# --- step 2: install base packages ---
step "Install base packages"

# Erlang/Elixir build deps + common CLI tools.
# fd-find: Debian's fd binary (we symlink fd→fdfind below)
PACKAGES=(
  fd-find
  ripgrep
  jq
  build-essential
  autoconf
  m4
  libncurses-dev
  libssl-dev
  libwxgtk3.2-dev
  libgl1-mesa-dev
  libglu1-mesa-dev
  libpng-dev
  libssh-dev
  unixodbc-dev
  xsltproc
  fop
  libxml2-utils
  inotify-tools
  curl
  ca-certificates
  unzip
  git
)

missing=()
for p in "${PACKAGES[@]}"; do
  if dpkg -s "$p" >/dev/null 2>&1; then continue; fi
  # Some package names differ across Debian versions; try apt-cache before giving up
  if apt-cache show "$p" >/dev/null 2>&1; then
    missing+=("$p")
  else
    warn "Package not found in apt cache: $p (skipping)"
  fi
done

if (( ${#missing[@]} == 0 )); then
  skip "All apt packages already installed"
else
  info "Installing ${#missing[@]} packages: ${missing[*]}"
  if [[ "$DRY_RUN" == 1 ]]; then
    info "(dry-run) would run: sudo apt-get install -y -qq ${missing[*]}"
  else
    spin "apt-get install" retry sudo apt-get install -y -qq "${missing[@]}"
  fi
fi

# --- step 3: fd symlink ---
step "Ensure 'fd' command on PATH"
if has_cmd fd; then
  skip "fd already on PATH ($(command -v fd))"
elif has_cmd fdfind; then
  mkdir -p "$HOME/.local/bin"
  if [[ "$DRY_RUN" == 1 ]]; then
    info "(dry-run) would link: $HOME/.local/bin/fd → $(command -v fdfind)"
  else
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
    ok "Linked: ~/.local/bin/fd → $(command -v fdfind)"
  fi
  if ! [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    warn "~/.local/bin is not on PATH — add it to your shell rc:"
    log "    ${DIM}export PATH=\"\$HOME/.local/bin:\$PATH\"${RESET}"
  fi
else
  fail "fdfind not installed — apt step must have failed"
  exit 1
fi

# --- step 4: verify ---
step "Verify base tools"
all_good=1
for c in jq rg fd curl make git; do
  if has_cmd "$c"; then
    ok "$c — $(command "$c" --version 2>/dev/null | head -1)"
  else
    fail "$c missing"
    all_good=0
  fi
done

(( all_good == 1 )) || { fail "Some base tools are missing"; exit 1; }

mark_done "$SECTION_ID"
ok "Section complete: $SECTION_ID"
