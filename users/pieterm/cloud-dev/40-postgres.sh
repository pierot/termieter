#!/usr/bin/env bash
# 40-postgres — PostgreSQL client (psql), needed for the `justified` DB allowlist

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

SECTION_ID="40-postgres"
section_done "$SECTION_ID" && exit 0

banner "PostgreSQL client" "🐘"

STEP_TOTAL=2

# --- step 1: install ---
step "Install postgresql-client"
if has_cmd psql; then
  skip "psql already installed: $(psql --version)"
else
  if [[ "$DRY_RUN" == 1 ]]; then
    info "(dry-run) would run: sudo apt-get install -y -qq postgresql-client"
  else
    retry sudo apt-get install -y -qq postgresql-client
    ok "Installed"
  fi
fi

# --- step 2: verify ---
step "Verify"
if [[ "$DRY_RUN" == 1 ]]; then
  info "(dry-run) skipping verification"
elif has_cmd psql; then
  ok "psql: $(psql --version)"
else
  fail "psql still not on PATH"
  exit 1
fi

mark_done "$SECTION_ID"
ok "Section complete: $SECTION_ID"
