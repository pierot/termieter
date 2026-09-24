#!/bin/bash

input=$(cat)
usage_file="/home/$USER/.cache/claude-usage.json"
temporary_file="${usage_file}.$$.tmp"
config_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

if command -v jq >/dev/null 2>&1 && command -v curl >/dev/null 2>&1; then
	updated_epoch=$(stat -c %Y "$usage_file" 2>/dev/null || printf '0')
	if (( $(date +%s) - updated_epoch >= 300 )); then
		token=$(jq -r '.claudeAiOauth.accessToken // empty' "$config_dir/.credentials.json" 2>/dev/null)
		response=$(curl -fsS --max-time 10 \
			-H "Authorization: Bearer $token" \
			-H 'anthropic-beta: oauth-2025-04-20' \
			-H 'User-Agent: claude-code/2.1' \
			https://api.anthropic.com/api/oauth/usage 2>/dev/null || true)
		if [[ -n "$token" ]] && jq -e '.five_hour.utilization != null' >/dev/null 2>&1 <<<"$response"; then
			five_hour_reset=$(jq -r '.five_hour.resets_at // empty' <<<"$response")
			seven_day_reset=$(jq -r '.seven_day.resets_at // empty' <<<"$response")
			five_hour_reset_epoch=$(date -d "$five_hour_reset" +%s 2>/dev/null || printf '0')
			seven_day_reset_epoch=$(date -d "$seven_day_reset" +%s 2>/dev/null || printf '0')
			jq --argjson five_hour_reset "$five_hour_reset_epoch" --argjson seven_day_reset "$seven_day_reset_epoch" '{updated_at: (now | todateiso8601), five_hour: {used_percentage: (.five_hour.utilization | round), resets_at: $five_hour_reset}, seven_day: {used_percentage: (.seven_day.utilization | round), resets_at: $seven_day_reset}}' <<<"$response" >"$temporary_file" && mv "$temporary_file" "$usage_file"
		fi
	fi
fi

plugin_dir=$(ls -d "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"/plugins/cache/claude-hud/claude-hud/*/ 2>/dev/null | awk -F/ '{ print $(NF-1) "\t" $(0) }' | sort -t. -k1,1n -k2,2n -k3,3n -k4,4n | tail -1 | cut -f2-)
exec "/home/jeroen/.bun/bin/bun" --env-file /dev/null "${plugin_dir}src/index.ts" <<<"$input"
