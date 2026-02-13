#!/bin/sh
set -e

# Resolve target pane: use argument, fall back to current TMUX_PANE
pane="${1:-${TMUX_PANE:-}}"

# Desired percentage of total height for the active pane (default 50%)
percent="${TMUX_RESIZE_PERCENT:-50}"
# Validate: must be a positive integer between 1 and 99
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

# Nothing to do without a pane target
if [ -z "$pane" ]; then
  exit 0
fi

# Gather pane info: id, top position, and height for each pane in the window
panes="$(tmux list-panes -t "$pane" -F "#{pane_id} #{pane_top} #{pane_height}")"
count="$(printf "%s\n" "$panes" | wc -l | tr -d ' ')"

# Only one pane — no resizing needed
if [ "$count" -lt 2 ]; then
  exit 0
fi

# Calculate target heights
total="$(printf "%s\n" "$panes" | awk '{s+=$3} END {print s}')"
other=$((count - 1))                  # number of non-active panes
half=$((total * percent / 100))       # target height for the active pane
max_half=$((total - other))           # cap: leave at least 1 row per other pane
if [ "$half" -gt "$max_half" ]; then
  half="$max_half"
fi
rest=$((total - half))                # remaining rows for the other panes
base=$((rest / other))                # base height per other pane
rem=$((rest - base * other))          # leftover rows to distribute one each

# Sort panes top-to-bottom for stable resize ordering
sorted="$(printf "%s\n" "$panes" | sort -k2,2n)"
active_id="$(tmux display -p -t "$pane" "#{pane_id}")"

# Resize the active pane first
tmux resize-pane -t "$active_id" -y "$half"

# Distribute remaining space evenly across the other panes
# The first `rem` panes get one extra row to account for the remainder
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
