#!/usr/bin/env bash
# 45-1password — 1Password CLI (`op`) via official apt repo
#
# Auth is handled separately (interactive `op signin` after install).
# 1Password enforces debsig-verify on their .deb, so the install also
# wires up /etc/debsig/policies and /usr/share/debsig/keyrings.

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

SECTION_ID="45-1password"
section_done "$SECTION_ID" && exit 0

banner "1Password CLI" "🔐"

# 1Password's GPG signing key ID — used as the debsig policy directory name.
OP_KEY_ID="AC2D62742012EA22"
OP_KEY_URL="https://downloads.1password.com/linux/keys/1password.asc"
OP_KEYRING="/usr/share/keyrings/1password-archive-keyring.gpg"
OP_SOURCES="/etc/apt/sources.list.d/1password.list"
OP_DEBSIG_POL_DIR="/etc/debsig/policies/${OP_KEY_ID}"
OP_DEBSIG_KEY_DIR="/usr/share/debsig/keyrings/${OP_KEY_ID}"
OP_DEBSIG_POL_URL="https://downloads.1password.com/linux/debian/debsig/1password.pol"

STEP_TOTAL=4

# --- step 1: short-circuit if already installed ---
step "Check for existing op"
if has_cmd op; then
  ok "op already installed: $(op --version)"
  mark_done "$SECTION_ID"
  exit 0
fi
info "op not present — installing"

# --- step 2: add signing key + apt source ---
step "Add 1Password apt repo and signing key"
if [[ "$DRY_RUN" == 1 ]]; then
  info "(dry-run) would fetch $OP_KEY_URL into $OP_KEYRING"
  info "(dry-run) would write $OP_SOURCES"
else
  arch=$(dpkg --print-architecture)
  retry bash -c "curl -fsSL '$OP_KEY_URL' | sudo gpg --dearmor --yes --output '$OP_KEYRING'"
  echo "deb [arch=${arch} signed-by=${OP_KEYRING}] https://downloads.1password.com/linux/debian/${arch} stable main" \
    | sudo tee "$OP_SOURCES" >/dev/null
  ok "Repo + key added"
fi

# --- step 3: debsig-verify policy (1Password enforces package signature) ---
step "Configure debsig-verify policy"
if [[ "$DRY_RUN" == 1 ]]; then
  info "(dry-run) would create $OP_DEBSIG_POL_DIR and $OP_DEBSIG_KEY_DIR"
else
  sudo mkdir -p "$OP_DEBSIG_POL_DIR" "$OP_DEBSIG_KEY_DIR"
  retry bash -c "curl -fsSL '$OP_DEBSIG_POL_URL' | sudo tee '$OP_DEBSIG_POL_DIR/1password.pol' >/dev/null"
  retry bash -c "curl -fsSL '$OP_KEY_URL' | sudo gpg --dearmor --yes --output '$OP_DEBSIG_KEY_DIR/debsig.gpg'"
  ok "debsig policy installed under $OP_KEY_ID"
fi

# --- step 4: install + verify ---
step "Install 1password-cli"
if [[ "$DRY_RUN" == 1 ]]; then
  info "(dry-run) would run: sudo apt-get update && sudo apt-get install -y 1password-cli"
else
  retry sudo apt-get update -qq
  spin "apt-get install 1password-cli" retry sudo apt-get install -y -qq 1password-cli
  if has_cmd op; then
    ok "op installed: $(op --version)"
    info "Next step (manual): run 'op signin' to authenticate this box"
  else
    fail "op not on PATH after install"
    exit 1
  fi
fi

mark_done "$SECTION_ID"
ok "Section complete: $SECTION_ID"
