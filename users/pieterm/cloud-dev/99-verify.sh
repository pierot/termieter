#!/usr/bin/env bash
# 99-verify — smoke-test every binary referenced in settings.json / CLAUDE.md / RTK.md

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

banner "Verification" "🔍"

# Bash subshells don't load .zshrc, so asdf's shell function is undefined here.
# Node/Ruby shims call `asdf` internally — source it before any command runs.
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  # shellcheck disable=SC1091
  set +u  # asdf.sh trips on nounset
  . "$HOME/.asdf/asdf.sh"
  set -u
fi

# name|category|version-flag
CHECKS=(
  "git|core|--version"
  "make|core|--version"
  "curl|core|--version"
  "jq|core|--version"
  "rg|core|--version"
  "fd|core|--version"
  "docker|core|--version"
  "nvim|editor|--version"
  "psql|db|--version"
  "asdf|toolchain|--version"
  "elixir|elixir|--version"
  "mix|elixir|--version"
  "node|node|--version"
  "npm|node|--version"
  "pnpm|node|--version"
  "bun|node|--version"
  "uv|python|--version"
  "tree-sitter|editor|--version"
  "rtk|rtk|--version"
)

STEP_TOTAL=${#CHECKS[@]}
pass=0; miss=0
declare -a MISSING

for entry in "${CHECKS[@]}"; do
  IFS='|' read -r name category flag <<<"$entry"
  step "[$category] $name"

  # asdf v0.14 is a shell function, not a binary — check the script file directly.
  if [[ "$name" == "asdf" ]] && ! has_cmd asdf && [[ -x "$HOME/.asdf/bin/asdf" ]]; then
    out=$("$HOME/.asdf/bin/asdf" --version 2>&1 | head -1 || true)
    ok "asdf — $out (via ~/.asdf/bin/asdf; function not exported to bash)"
    pass=$((pass + 1))
    continue
  fi

  if ! has_cmd "$name"; then
    fail "$name not on PATH"
    MISSING+=("$name")
    miss=$((miss + 1))
    continue
  fi

  # Run the version command; treat a non-zero exit as a failure even if the
  # binary exists (e.g. a broken asdf shim that can't find its dependency).
  # Disarm the ERR trap + errexit for the call: piping to `head` causes
  # SIGPIPE on the producer which trips ERR independently of set -e.
  set +e
  trap - ERR
  out=$("$name" "$flag" 2>&1)
  rc=$?
  set -e
  trap 'on_err $LINENO' ERR
  out=${out%%$'\n'*}   # first line, no pipe

  if (( rc == 0 )); then
    ok "$name — $out"
    pass=$((pass + 1))
  else
    fail "$name exists but '$name $flag' exits $rc: $out"
    MISSING+=("$name")
    miss=$((miss + 1))
  fi
done

# Special check: rtk gain (distinguishes rtk-ai/rtk from reachingforthejack/rtk)
log ""
info "Cross-check: 'rtk gain' (rtk-ai/rtk only)"
if has_cmd rtk; then
  if rtk gain >/dev/null 2>&1; then
    ok "rtk gain works — confirmed rtk-ai/rtk"
  else
    fail "rtk on PATH but 'rtk gain' fails — likely the wrong rtk (reachingforthejack/rtk)"
  fi
else
  skip "rtk not installed"
fi

# PATH hints
log ""
info "PATH segments relevant to installs:"
for p in "$HOME/.local/bin" "$HOME/.bun/bin" "$HOME/.cargo/bin" "$HOME/.asdf/shims"; do
  if [[ ":$PATH:" == *":$p:"* ]]; then
    ok "on PATH: $p"
  elif [[ -d "$p" ]]; then
    warn "exists but NOT on PATH: $p"
  fi
done

# Summary
log ""
banner "Summary" "📊"
log "  ${GREEN}Passed: ${pass}${RESET}"
log "  ${RED}Missing: ${miss}${RESET}"
if (( miss > 0 )); then
  log ""
  log "Missing: ${MISSING[*]}"
  log ""
  info "To re-attempt the relevant section, e.g.:"
  log "    ${DIM}./install.sh --only=10 --force${RESET}"
  exit 1
fi

ok "Everything looks good."
exit 0
