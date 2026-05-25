#!/usr/bin/env bash
# Shared helpers for stanley install scripts.
# Source from each section script: source "$(dirname "$0")/lib/common.sh"

set -Eeuo pipefail

# --- colors (degrade gracefully on non-TTY / NO_COLOR) ---
if [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]] \
   && command -v tput >/dev/null 2>&1 \
   && [[ $(tput colors 2>/dev/null || echo 0) -ge 8 ]]; then
  BOLD=$(tput bold); DIM=$(tput dim); RESET=$(tput sgr0)
  RED=$(tput setaf 1); GREEN=$(tput setaf 2); YELLOW=$(tput setaf 3)
  BLUE=$(tput setaf 4); CYAN=$(tput setaf 6); MAGENTA=$(tput setaf 5)
else
  BOLD=""; DIM=""; RESET=""; RED=""; GREEN=""; YELLOW=""; BLUE=""; CYAN=""; MAGENTA=""
fi

ICON_OK="${GREEN}✓${RESET}"
ICON_SKIP="${DIM}⏭${RESET}"
ICON_FAIL="${RED}✗${RESET}"
ICON_WARN="${YELLOW}⚠${RESET}"
ICON_INFO="${BLUE}ℹ${RESET}"
ICON_WORK="${CYAN}⚙${RESET}"

# --- env defaults (overridable) ---
: "${INSTALL_LOG:=/dev/null}"
: "${STATE_FILE:=$HOME/.termieter/users/pieterm/stanley/.state}"
: "${YES:=0}"
: "${DRY_RUN:=0}"
: "${FORCE:=0}"

# --- logging primitives ---
_log()  { printf '%b\n' "$*" | tee -a "$INSTALL_LOG" >&2; }
log()   { _log "$*"; }
info()  { _log "${ICON_INFO} $*"; }
ok()    { _log "${ICON_OK} $*"; }
skip()  { _log "${ICON_SKIP} $*"; }
warn()  { _log "${ICON_WARN} $*"; }
fail()  { _log "${ICON_FAIL} $*"; }

banner() {
  local title=$1
  local emoji=${2:-📦}
  local line
  line=$(printf '─%.0s' $(seq 1 60))
  _log ""
  _log "${BOLD}${BLUE}${line}${RESET}"
  _log "${BOLD}${emoji}  ${title}${RESET}"
  _log "${BOLD}${BLUE}${line}${RESET}"
}

# --- step counter (set STEP_TOTAL before first step()) ---
STEP_TOTAL=${STEP_TOTAL:-0}
STEP_CURRENT=0
step() {
  STEP_CURRENT=$((STEP_CURRENT + 1))
  _log ""
  _log "${BOLD}[${STEP_CURRENT}/${STEP_TOTAL}]${RESET} ${ICON_WORK} $*"
}

# --- ERR trap with context ---
on_err() {
  local exit_code=$?
  local lineno=$1
  fail "Aborted at line ${lineno} (exit ${exit_code}): ${BASH_COMMAND}"
  exit "$exit_code"
}
trap 'on_err $LINENO' ERR

has_cmd() { command -v "$1" >/dev/null 2>&1; }

# --- retry with exponential backoff ---
retry() {
  local max=${RETRY_MAX:-3}
  local delay=${RETRY_DELAY:-2}
  local n=1
  while true; do
    if "$@"; then return 0; fi
    if (( n >= max )); then
      fail "Gave up after ${max} attempts: $*"
      return 1
    fi
    warn "Attempt ${n}/${max} failed, retrying in ${delay}s..."
    sleep "$delay"
    delay=$((delay * 2))
    n=$((n + 1))
  done
}

# --- y/n prompt (auto-yes when YES=1 or stdin is not a TTY) ---
confirm() {
  local prompt=${1:-"Continue?"}
  [[ "${YES:-0}" == "1" ]] && return 0
  [[ ! -t 0 ]] && return 0
  local reply
  read -r -p "$(printf '%s [y/N] ' "$prompt")" reply
  [[ "$reply" =~ ^[Yy]$ ]]
}

# --- dry-run aware command runner ---
run() {
  if [[ "${DRY_RUN:-0}" == "1" ]]; then
    _log "${DIM}\$ $*${RESET}"
  else
    _log "${DIM}\$ $*${RESET}"
    "$@"
  fi
}

# --- spinner for long-running ops ---
spin() {
  local msg=$1; shift
  if [[ "${DRY_RUN:-0}" == "1" || ! -t 2 ]]; then
    info "$msg"
    "$@"
    return $?
  fi
  local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  ( trap - ERR; "$@" ) &
  local pid=$!
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf '\r%s %s' "${frames[i]}" "$msg" >&2
    i=$(( (i + 1) % ${#frames[@]} ))
    sleep 0.1
  done
  set +e
  wait "$pid"
  local rc=$?
  set -e
  printf '\r\033[K' >&2
  if (( rc == 0 )); then ok "$msg"; else fail "$msg (exit $rc)"; fi
  return $rc
}

# --- state (resume support) ---
mark_done() {
  mkdir -p "$(dirname "$STATE_FILE")"
  grep -qx "$1=done" "$STATE_FILE" 2>/dev/null && return 0
  echo "$1=done" >> "$STATE_FILE"
}

is_done() {
  [[ -f "$STATE_FILE" ]] && grep -qx "$1=done" "$STATE_FILE" 2>/dev/null
}

section_done() {
  local id=$1
  if [[ "${FORCE:-0}" != "1" ]] && is_done "$id"; then
    skip "[$id] already completed (use --force to re-run)"
    return 0
  fi
  return 1
}

# --- timer helpers ---
timer_start() { TIMER_START=$(date +%s); }
timer_elapsed() {
  local now end
  end=$(date +%s)
  local s=$((end - TIMER_START))
  printf '%dm%02ds' $((s/60)) $((s%60))
}
