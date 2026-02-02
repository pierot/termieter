#!/bin/sh
set -e

pane="${1:-${TMUX_PANE:-}}"
percent="${TMUX_RESIZE_PERCENT:-50}"
case "$percent" in
  ''|*[!0-9]*)
    percent=50
    ;;
  0)
    percent=1
    ;;
esac
if [ "$percent" -gt 99 ]; then
  percent=99
fi

if [ -z "$pane" ]; then
  exit 0
fi

panes="$(tmux list-panes -t "$pane" -F "#{pane_id} #{pane_top} #{pane_height}")"
count="$(printf "%s\n" "$panes" | wc -l | tr -d ' ')"

if [ "$count" -lt 2 ]; then
  exit 0
fi

total="$(printf "%s\n" "$panes" | awk '{s+=$3} END {print s}')"
other=$((count - 1))
half=$((total * percent / 100))
max_half=$((total - other))
if [ "$half" -gt "$max_half" ]; then
  half="$max_half"
fi
rest=$((total - half))
base=$((rest / other))
rem=$((rest - base * other))

sorted="$(printf "%s\n" "$panes" | sort -k2,2n)"
active_id="$(tmux display -p -t "$pane" "#{pane_id}")"

tmux resize-pane -t "$active_id" -y "$half"

i=0
printf "%s\n" "$sorted" | while read -r id _ height; do
  if [ "$id" = "$active_id" ]; then
    continue
  fi
  if [ "$i" -lt "$rem" ]; then
    target=$((base + 1))
  else
    target=$base
  fi
  tmux resize-pane -t "$id" -y "$target"
  i=$((i + 1))
done
