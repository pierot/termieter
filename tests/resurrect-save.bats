#!/usr/bin/env bats
# BATS tests for tmux/resurrect-save.sh
# Each test runs its own tmux server and a stub tmux-resurrect save.sh

setup() {
    export TEST_DIR="$(mktemp -d)"
    export HOME="$TEST_DIR/home"

    # Own tmux server: the socket lives in TEST_DIR, not in the user's server
    export TMUX_TMPDIR="$TEST_DIR"
    unset TMUX
    unset XDG_DATA_HOME

    RESURRECT_DIR="$HOME/.local/share/tmux/resurrect"
    CALLS="$TEST_DIR/save-calls"
    SCRIPT="$BATS_TEST_DIRNAME/../tmux/resurrect-save.sh"
    mkdir -p "$RESURRECT_DIR"

    # Stub save.sh records its first argument ("quiet", or "none")
    local stub_dir="$HOME/.termieter/tmux/tmux-resurrect/scripts"
    mkdir -p "$stub_dir"
    cat > "$stub_dir/save.sh" <<EOF
#!/usr/bin/env bash
echo "\${1:-none}" >> "$CALLS"
EOF
    chmod +x "$stub_dir/save.sh"
}

teardown() {
    tmux kill-server 2>/dev/null || true
    rm -rf "$TEST_DIR"
}

# Start the test tmux server with $1 panes
start_server() {
    tmux -f /dev/null new-session -d -s test
    # No seq here: on macOS, "seq 2 1" counts down and prints 2 lines
    local i=1
    while [ "$i" -lt "$1" ]; do
        tmux new-window -t test
        i=$((i + 1))
    done
}

@test "skips when no tmux server runs" {
    run "$SCRIPT"
    [ "$status" -eq 0 ]
    [ ! -e "$CALLS" ]
    grep -q "skip: no tmux server running" "$RESURRECT_DIR/save.log"
}

@test "skips when the server has fewer than 5 panes" {
    start_server 4
    run "$SCRIPT"
    [ "$status" -eq 0 ]
    [ ! -e "$CALLS" ]
    grep -q "skip: 4 panes, minimum is 5" "$RESURRECT_DIR/save.log"
}

@test "saves when the server has 5 panes" {
    start_server 5
    run "$SCRIPT"
    [ "$status" -eq 0 ]
    [ "$(cat "$CALLS")" = "quiet" ]
}

@test "force saves without the pane check and without quiet" {
    start_server 1
    run "$SCRIPT" force
    [ "$status" -eq 0 ]
    [ "$(cat "$CALLS")" = "none" ]
}
