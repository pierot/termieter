#!/usr/bin/env bash
# Provisioning orchestrator
# Runs section scripts in order with shared state, logging, dry-run, resume.

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

# --- logfile per run ---
mkdir -p "$SCRIPT_DIR/logs"
INSTALL_LOG="$SCRIPT_DIR/logs/$(date +%Y-%m-%d-%H%M%S).log"
touch "$INSTALL_LOG"
export INSTALL_LOG

# --- flag parsing ---
YES=0; DRY_RUN=0; FORCE=0; RESUME=0; VERIFY_ONLY=0
ONLY=""; SKIP=""

usage() {
  cat <<EOF
Cloud dev — install runtime, tools, plugins

Usage: $(basename "$0") [flags]

Flags:
  -y, --yes         Auto-accept all prompts
      --dry-run     Print commands without executing
      --force       Re-run sections marked done
      --resume      Skip sections marked done (default behavior, explicit flag for clarity)
      --verify      Run only 99-verify.sh
      --only=A,B    Run only sections with these prefixes (e.g. --only=00,10)
      --skip=A,B    Skip sections with these prefixes
      --reset       Wipe state file (run everything fresh)
  -h, --help        Show this help

Sections:
  00-bootstrap        apt packages, fd symlink
  05-neovim           Neovim (official tarball, latest stable)
  10-asdf             asdf + Erlang + Elixir + Node + pnpm
  20-bun              Bun runtime
  30-rtk              RTK (rtk-ai/rtk) binary
  40-postgres         postgresql-client
  45-1password        1Password CLI (op) via official apt repo
  50-claude-plugins   Print Claude Code plugin commands (manual)
  99-verify           Smoke-test every binary

Examples:
  ./install.sh                     # interactive, runs everything new
  ./install.sh -y                  # unattended
  ./install.sh --only=10,20        # only asdf + bun
  ./install.sh --skip=10           # everything except asdf
  ./install.sh --verify            # just verify what's installed
  ./install.sh --reset --yes       # wipe state and reinstall from scratch
EOF
}

while (( $# > 0 )); do
  case $1 in
    -y|--yes)     YES=1 ;;
    --dry-run)    DRY_RUN=1 ;;
    --force)      FORCE=1 ;;
    --resume)     RESUME=1 ;;
    --verify)     VERIFY_ONLY=1 ;;
    --only=*)     ONLY="${1#--only=}" ;;
    --skip=*)     SKIP="${1#--skip=}" ;;
    --reset)      rm -f "$STATE_FILE"; info "State file cleared" ;;
    -h|--help)    usage; exit 0 ;;
    *)            fail "Unknown flag: $1"; usage; exit 2 ;;
  esac
  shift
done
export YES DRY_RUN FORCE

# --- header ---
banner "Provisioning bring-up" "🚀"
info "Host:    $(uname -s) $(uname -r) ($(. /etc/os-release && echo "$PRETTY_NAME" 2>/dev/null || echo unknown))"
info "User:    $(whoami)"
info "Logfile: $INSTALL_LOG"
[[ "$DRY_RUN" == 1 ]] && warn "DRY RUN — no changes will be made"
[[ "$FORCE"   == 1 ]] && warn "FORCE — sections marked done will re-run"

# --- verify-only short-circuit ---
if [[ "$VERIFY_ONLY" == 1 ]]; then
  exec bash "$SCRIPT_DIR/99-verify.sh"
fi

# --- section list ---
ALL_SECTIONS=(
  00-bootstrap
  05-neovim
  10-asdf
  20-bun
  30-rtk
  40-postgres
  45-1password
  50-claude-plugins
  99-verify
)

selected=()
for s in "${ALL_SECTIONS[@]}"; do
  prefix=${s%%-*}
  if [[ -n "$ONLY" ]] && [[ ! ",$ONLY," == *",$prefix,"* ]]; then continue; fi
  if [[ -n "$SKIP" ]] && [[ ",$SKIP," == *",$prefix,"* ]]; then continue; fi
  selected+=("$s")
done

if (( ${#selected[@]} == 0 )); then
  fail "No sections selected"
  exit 1
fi

info "Selected sections: ${selected[*]}"

# --- sudo keepalive (skip if dry-run or no sudo-needing section) ---
needs_sudo=0
for s in "${selected[@]}"; do
  case $s in 00-bootstrap|40-postgres|45-1password) needs_sudo=1 ;; esac
done
if (( needs_sudo == 1 )) && [[ "$DRY_RUN" == 0 ]]; then
  info "Caching sudo credentials (may prompt)..."
  sudo -v
  ( while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done ) 2>/dev/null &
  SUDO_KEEPALIVE_PID=$!
  trap '[[ -n "${SUDO_KEEPALIVE_PID:-}" ]] && kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true' EXIT
fi

# --- run sections ---
declare -A RESULTS
declare -A TIMINGS
overall_start=$(date +%s)

for s in "${selected[@]}"; do
  script="$SCRIPT_DIR/$s.sh"
  if [[ ! -f "$script" ]]; then
    warn "Missing: $script — skipping"
    RESULTS[$s]="missing"
    continue
  fi
  chmod +x "$script" 2>/dev/null || true

  section_start=$(date +%s)
  if bash "$script"; then
    rc=0
  else
    rc=$?
  fi
  section_end=$(date +%s)
  elapsed=$((section_end - section_start))
  TIMINGS[$s]=$(printf '%dm%02ds' $((elapsed/60)) $((elapsed%60)))

  if (( rc == 0 )); then
    RESULTS[$s]="ok"
  else
    RESULTS[$s]="fail($rc)"
    fail "Section $s failed (exit $rc) — stopping. Rerun with --resume to continue past completed sections."
    break
  fi
done

# --- summary ---
overall_end=$(date +%s)
overall_elapsed=$((overall_end - overall_start))
total_time=$(printf '%dm%02ds' $((overall_elapsed/60)) $((overall_elapsed%60)))

banner "Summary" "📊"
for s in "${selected[@]}"; do
  result=${RESULTS[$s]:-not-run}
  timing=${TIMINGS[$s]:-—}
  case $result in
    ok)      printf '  %s %-22s %s\n' "$ICON_OK"   "$s" "$timing" | tee -a "$INSTALL_LOG" >&2 ;;
    missing) printf '  %s %-22s missing script\n'  "$ICON_WARN" "$s"           | tee -a "$INSTALL_LOG" >&2 ;;
    fail*)   printf '  %s %-22s %s (%s)\n' "$ICON_FAIL" "$s" "$timing" "$result" | tee -a "$INSTALL_LOG" >&2 ;;
    *)       printf '  %s %-22s not run\n'         "$ICON_SKIP" "$s"           | tee -a "$INSTALL_LOG" >&2 ;;
  esac
done
log ""
info "Total elapsed: ${total_time}"
info "Log:           ${INSTALL_LOG}"

# --- exit code reflects worst result ---
for s in "${selected[@]}"; do
  case "${RESULTS[$s]:-}" in
    fail*) exit 1 ;;
  esac
done
ok "All selected sections completed."
exit 0
