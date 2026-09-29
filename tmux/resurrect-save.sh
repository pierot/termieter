#!/usr/bin/env bash
# tmux-resurrect save every 6 hours, triggered by a launchd agent at
# 00:00, 06:00, 12:00 and 18:00. See tmux/be.jackjoe.tmux-resurrect-save.plist.
#
# Safe to run any time and on any machine: it no-ops when no tmux server
# is running, so it does nothing on hosts where the agent isn't loaded.
#
# Usage: resurrect-save.sh [key|force]
#   (none)  launchd run: quiet save, with the pane check
#   key     prefix C-s: resurrect's own messages, with the pane check
#   force   prefix M-s: resurrect's own messages, without the pane check
#
# The pane check skips the save when the server has fewer than MIN_PANES
# panes, for example after a crash or restart before the restore.
#
# Install: cp ~/.termieter/tmux/be.jackjoe.tmux-resurrect-save.plist ~/Library/LaunchAgents/
# Load:    launchctl bootstrap gui/$UID ~/Library/LaunchAgents/be.jackjoe.tmux-resurrect-save.plist
# Unload:  launchctl bootout gui/$UID/be.jackjoe.tmux-resurrect-save

# launchd runs with a minimal PATH; cover both Apple Silicon and Intel brew.
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# launchd provides no locale. Under the C locale, tmux-resurrect's sed/awk/read
# pipeline hits "illegal byte sequence" on non-ASCII pane titles/paths and
# silently saves an empty stub (only the `state` line). Force a UTF-8 locale.
export LANG="${LANG:-en_US.UTF-8}"

# Same default as tmux-resurrect/scripts/helpers.sh. Do not create
# ~/.tmux/resurrect here: when it exists, tmux-resurrect switches to it.
if [ -d "${HOME}/.tmux/resurrect" ]; then
  RESURRECT_DIR="${HOME}/.tmux/resurrect"
else
  RESURRECT_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/tmux/resurrect"
fi
LOG="${RESURRECT_DIR}/save.log"
SAVE="${HOME}/.termieter/tmux/tmux-resurrect/scripts/save.sh"
MODE="${1:-}"
MIN_PANES=5

mkdir -p "${RESURRECT_DIR}"

log() { printf '%s %s\n' "$(date '+%Y-%m-%dT%H:%M:%S')" "$1" >>"${LOG}"; }

# Nothing to save if no tmux server is running.
if ! tmux list-sessions >/dev/null 2>&1; then
  log "skip: no tmux server running"
  exit 0
fi

if [ "${MODE}" != "force" ]; then
  panes=$(tmux list-panes -a | wc -l | tr -d ' ')
  if [ "${panes}" -lt "${MIN_PANES}" ]; then
    log "skip: ${panes} panes, minimum is ${MIN_PANES}"
    if [ "${MODE}" = "key" ]; then
      tmux display-message "Save skipped: ${panes} panes, minimum is ${MIN_PANES}. Force: prefix M-s"
    fi
    exit 0
  fi
fi

# resurrect's save.sh is silent with "quiet" and shows its messages without it.
output=""
if [ -z "${MODE}" ]; then
  output="quiet"
fi

if "${SAVE}" "${output}"; then
  log "saved -> $(basename "$(readlink "${RESURRECT_DIR}/last" 2>/dev/null)")"
else
  rc=$?
  log "error: save.sh exited ${rc}"
  exit "${rc}"
fi
