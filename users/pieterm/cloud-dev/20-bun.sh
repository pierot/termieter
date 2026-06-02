#!/usr/bin/env bash
# 20-bun — Bun JavaScript runtime (required by claude-hud statusline)

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

SECTION_ID="20-bun"
section_done "$SECTION_ID" && exit 0

banner "Bun runtime" "🥟"

STEP_TOTAL=2

# --- step 1: install ---
step "Install Bun"
BUN_BIN="$HOME/.bun/bin/bun"

if has_cmd bun; then
  skip "Bun already on PATH: $(bun --version)"
elif [[ -x "$BUN_BIN" ]]; then
  skip "Bun installed at $BUN_BIN but not on PATH ($("$BUN_BIN" --version))"
else
  if [[ "$DRY_RUN" == 1 ]]; then
    info "(dry-run) would run: curl -fsSL https://bun.sh/install | bash"
  else
    info "Fetching official Bun installer from bun.sh..."
    # Download first to a temp file so we can inspect on failure
    tmp=$(mktemp)
    if retry curl -fsSL https://bun.sh/install -o "$tmp"; then
      spin "Running Bun installer" bash "$tmp"
      rm -f "$tmp"
    else
      rm -f "$tmp"
      fail "Could not download Bun installer"
      exit 1
    fi
  fi
fi

# --- step 2: verify + PATH guidance ---
step "Verify Bun"
if has_cmd bun; then
  ok "bun on PATH: $(bun --version)"
elif [[ -x "$BUN_BIN" ]]; then
  ok "bun installed at $BUN_BIN ($("$BUN_BIN" --version))"
  warn "Add ~/.bun/bin to your PATH (the installer normally appends to ~/.zshrc)"
  log "    ${DIM}export PATH=\"\$HOME/.bun/bin:\$PATH\"${RESET}"
else
  fail "Bun install did not produce a binary"
  exit 1
fi

mark_done "$SECTION_ID"
ok "Section complete: $SECTION_ID"
