#!/usr/bin/env bash
# Nightly tmux-resurrect save, triggered by a launchd agent at 02:00.
# See tmux/be.jackjoe.tmux-resurrect-nightly.plist.
#
# Safe to run any time and on any machine: it no-ops when no tmux server
# is running, so it does nothing on hosts where the agent isn't loaded.

# launchd runs with a minimal PATH; cover both Apple Silicon and Intel brew.
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# launchd provides no locale. Under the C locale, tmux-resurrect's sed/awk/read
# pipeline hits "illegal byte sequence" on non-ASCII pane titles/paths and
# silently saves an empty stub (only the `state` line). Force a UTF-8 locale.
export LANG="${LANG:-en_US.UTF-8}"

RESURRECT_DIR="${HOME}/.tmux/resurrect"
LOG="${RESURRECT_DIR}/nightly-save.log"
SAVE="${HOME}/.termieter/tmux/tmux-resurrect/scripts/save.sh"

mkdir -p "${RESURRECT_DIR}"

log() { printf '%s %s\n' "$(date '+%Y-%m-%dT%H:%M:%S')" "$1" >>"${LOG}"; }

# Nothing to save if no tmux server is running.
if ! tmux list-sessions >/dev/null 2>&1; then
  log "skip: no tmux server running"
  exit 0
fi

if "${SAVE}" quiet; then
  log "saved -> $(basename "$(readlink "${RESURRECT_DIR}/last" 2>/dev/null)")"
else
  rc=$?
  log "error: save.sh exited ${rc}"
  exit "${rc}"
fi
