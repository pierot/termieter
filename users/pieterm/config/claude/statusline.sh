#!/usr/bin/env bash
# Claude Code statusline: run the newest cached claude-hud version.
cols=$(stty size </dev/tty 2>/dev/null | awk '{print $2}')
export COLUMNS=$(( ${cols:-120} > 4 ? ${cols:-120} - 4 : 1 ))

plugin_dir=$(ls -d "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"/plugins/cache/*/claude-hud/*/ 2>/dev/null \
  | awk -F/ '{ print $(NF-1) "\t" $0 }' \
  | grep -E '^[0-9]+\.[0-9]+\.[0-9]+[[:space:]]' \
  | sort -t. -k1,1n -k2,2n -k3,3n -k4,4n \
  | tail -1 | cut -f2-)

# PATH is not guaranteed in the statusline subprocess, so check the common
# install paths too. Prefer bun, which runs the TypeScript source directly.
# --env-file /dev/null stops bun from auto-loading a project .env.
for bun in "$(command -v bun)" /opt/homebrew/bin/bun "$HOME/.bun/bin/bun"; do
  [[ -x "$bun" ]] && exec "$bun" --env-file /dev/null "${plugin_dir}src/index.ts"
done

# Fall back to node, which runs the build the plugin ships.
for node in "$(command -v node)" /opt/homebrew/bin/node /usr/local/bin/node; do
  [[ -x "$node" ]] && exec "$node" "${plugin_dir}dist/index.js"
done
