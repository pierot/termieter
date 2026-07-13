#!/usr/bin/env bash
# 50-claude-plugins — informational; plugins can only be installed inside Claude Code

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

SECTION_ID="50-claude-plugins"
section_done "$SECTION_ID" && exit 0

banner "Claude Code plugins (manual)" "🤖"

cat <<EOF

Plugins listed in ~/.claude/settings.json must be installed from inside
Claude Code (slash commands). Copy/paste the block below into a running
Claude Code session:

${BOLD}── Add marketplaces ─────────────────────────────${RESET}
  /plugin marketplace add anthropics/claude-code
  /plugin marketplace add mksglu/context-mode
  /plugin marketplace add jarrodwatts/claude-hud
  /plugin marketplace add backnotprop/plannotator
  /plugin marketplace add jmagar/claude-homelab

${BOLD}── Install plugins ──────────────────────────────${RESET}
  /plugin install typescript-lsp@claude-plugins-official
  /plugin install frontend-design@claude-plugins-official
  /plugin install code-simplifier@claude-plugins-official
  /plugin install context-mode@context-mode
  /plugin install claude-hud@claude-hud
  /plugin install plannotator@plannotator
  /plugin install unraid-mcp@claude-homelab

${BOLD}── Post-install ─────────────────────────────────${RESET}
  /claude-hud:setup            # wire up the statusline
  /context-mode:ctx-doctor     # smoke-test context-mode

EOF

# Check things the shell side CAN check
info "Local prerequisites for Claude plugins:"
for tool in bun node; do
  if has_cmd "$tool"; then
    ok "$tool present — needed by claude-hud statusline"
  else
    warn "$tool missing — claude-hud statusline will not work until installed"
  fi
done

# The SessionStart hook in settings.json points to a macOS-only path
HOOK_PATH="/Users/pieterm/.claude/hooks/context-mode-cache-heal.mjs"
LINUX_PATH="$HOME/.claude/hooks/context-mode-cache-heal.mjs"
if [[ -e "$HOOK_PATH" ]]; then
  ok "SessionStart hook present at $HOOK_PATH"
elif [[ -e "$LINUX_PATH" ]]; then
  warn "SessionStart hook is at $LINUX_PATH but settings.json points to $HOOK_PATH"
  warn "Either symlink it: ${DIM}sudo mkdir -p /Users/pieterm/.claude/hooks && sudo ln -s $LINUX_PATH $HOOK_PATH${RESET}"
  warn "Or edit settings.json to use \$HOME/.claude/hooks/..."
else
  warn "SessionStart hook missing on both macOS and Linux paths — context-mode cache won't auto-heal at session start"
fi

mark_done "$SECTION_ID"
ok "Section complete: $SECTION_ID"
