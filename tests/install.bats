#!/usr/bin/env bats
# BATS tests for termieter install script
# Tests script behavior, option parsing, and function logic

# Setup runs before each test
setup() {
    # Load the install script functions for testing
    # We source it in a way that prevents execution
    export TEST_MODE=1

    # Create temporary test directory
    export TEST_DIR="$(mktemp -d)"
    export TEST_HOME="$TEST_DIR/home"
    mkdir -p "$TEST_HOME"

    # Mock HOME for tests
    export ORIGINAL_HOME="$HOME"
    export HOME="$TEST_HOME"
}

# Teardown runs after each test
teardown() {
    # Restore original HOME
    export HOME="$ORIGINAL_HOME"

    # Clean up test directory
    if [[ -n "$TEST_DIR" ]] && [[ -d "$TEST_DIR" ]]; then
        rm -rf "$TEST_DIR"
    fi
}

#######################################
# Syntax and Static Analysis Tests
#######################################

@test "install script has valid bash syntax" {
    bash -n install
}

@test "install script is executable" {
    [[ -x install ]]
}

@test "install script has proper shebang" {
    head -1 install | grep -q "^#!/bin/bash"
}

#######################################
# Help and Usage Tests
#######################################

@test "install script shows help with -h flag" {
    run ./install -h
    [[ "$status" -eq 0 ]]
    [[ "$output" =~ "Usage:" ]]
}

@test "install script shows help with --help flag" {
    run ./install --help
    [[ "$status" -eq 0 ]]
    [[ "$output" =~ "Usage:" ]]
}

@test "help text includes all options" {
    run ./install -h
    [[ "$output" =~ "-h" ]]
    [[ "$output" =~ "-u" ]]
    [[ "$output" =~ "-d" ]]
    [[ "$output" =~ "-s" ]]
    [[ "$output" =~ "update" ]]
    [[ "$output" =~ "directory" ]]
    [[ "$output" =~ "starship" ]]
}

@test "help text includes remote usage example" {
    run ./install -h
    [[ "$output" =~ "Remote usage:" ]]
    [[ "$output" =~ "curl" ]]
}

#######################################
# Function Tests
#######################################

@test "_contains_element finds element in array" {
    # Source the script to load functions
    source <(sed -n '/^_contains_element/,/^}/p' install)

    test_array=("foo" "bar" "baz")
    run _contains_element "bar" "${test_array[@]}"
    [[ "$status" -eq 0 ]]
}

@test "_contains_element returns 1 when element not in array" {
    # Source the script to load functions
    source <(sed -n '/^_contains_element/,/^}/p' install)

    test_array=("foo" "bar" "baz")
    run _contains_element "qux" "${test_array[@]}"
    [[ "$status" -eq 1 ]]
}

@test "_contains_element handles empty array" {
    # Source the script to load functions
    source <(sed -n '/^_contains_element/,/^}/p' install)

    test_array=()
    run _contains_element "foo" "${test_array[@]}"
    [[ "$status" -eq 1 ]]
}

#######################################
# Color Code Tests
#######################################

@test "color variables are defined" {
    grep -q "COL_GREEN=" install
    grep -q "COL_BLUE=" install
    grep -q "COL_RED=" install
    grep -q "COL_YELLOW=" install
    grep -q "COL_RESET=" install
}

@test "color codes use valid ANSI escape sequences" {
    # Check that color variables contain escape sequences
    grep "COL_GREEN=" install | grep -q "\\\\x1b"
    grep "COL_RESET=" install | grep -q "\\\\x1b"
}

#######################################
# Git Dependency Tests
#######################################

@test "install script checks for git" {
    grep -q "hash git" install
}

@test "install script configures git HTTPS rewrite" {
    grep -q 'git config --global url."https://".insteadOf git://' install
}

#######################################
# Directory Structure Tests
#######################################

@test "install script creates backup directory" {
    grep -q "mkdir -p.*bash_backup" install
}

@test "install script uses temp directory" {
    grep -q "temp_dir=" install
    grep -q "mkdir -p.*temp_dir" install
}

#######################################
# Option Parsing Tests
#######################################

@test "install script accepts -d option" {
    grep -q 'getopts.*d' install
}

@test "install script accepts -u option" {
    grep -q 'getopts.*u' install
}

@test "install script accepts -s option" {
    grep -q 'getopts.*s' install
}

@test "install script accepts -h option" {
    grep -q 'getopts.*h' install
}

@test "install script handles long options" {
    grep -q 'directory)' install
    grep -q 'starship)' install
}

#######################################
# Installation Logic Tests
#######################################

@test "install script clones termieter repository" {
    grep -q "git clone.*termieter" install
}

@test "install script has SSH fallback to HTTPS" {
    # Check for both SSH and HTTPS clone attempts
    grep -q "git@github.com:pierot/termieter" install
    grep -q "https://github.com/pierot/termieter" install
}

@test "install script respects update mode" {
    grep -q 'if.*update.*eq 0' install
}

@test "install script creates symlinks" {
    grep -q "ln -sf" install
}

@test "install script backs up existing files" {
    grep -q "mv.*bash_backup" install
}

#######################################
# tmux Plugin Tests
#######################################

@test "install script clones tmux-resurrect" {
    grep -q "tmux-resurrect" install
}

@test "install script checks if tmux-resurrect exists before cloning" {
    grep -q "if.*tmux-resurrect.*then" install
}

#######################################
# Starship Tests
#######################################

@test "install script has starship installation option" {
    grep -q "starship" install
}

@test "install script detects existing starship" {
    grep -q "hash starship" install
}

@test "install script handles starship interactive prompt" {
    grep -q "Install starship?" install
}

@test "install script detects macOS for starship" {
    grep -q "uname.*Darwin" install
}

@test "install script uses brew for starship on macOS" {
    grep -q "brew install starship" install
}

#######################################
# User-specific Configuration Tests
#######################################

@test "install script handles user-specific files" {
    grep -q "users/\$USER" install
}

@test "install script creates .local files" {
    grep -q "\.local" install
}

@test "install script defines local files array" {
    grep -q 'locals=(' install
}

@test "local files array includes expected files" {
    grep 'locals=(' install | grep -q "vimrc"
    grep 'locals=(' install | grep -q "zshrc"
    grep 'locals=(' install | grep -q "gitconfig"
}

#######################################
# .config Directory Tests
#######################################

@test "install script handles .config directory" {
    grep -q "\.config" install
}

@test "install script backs up existing .config" {
    grep -q "config.backup" install
}

#######################################
# Error Handling Tests
#######################################

@test "install script exits on missing git" {
    grep -q "exit 1" install
}

@test "install script validates function parameters" {
    # Check for parameter validation in functions
    grep -q '\[\[ -z.*\]\].*exit 1' install
}

#######################################
# Code Quality Tests
#######################################

@test "install script uses [[  ]] instead of [  ]" {
    # Modern bash should use [[ ]] for tests
    # Count [[ vs [ (excluding shebang and comments)
    double_bracket_count=$(grep -v '^#' install | grep -c '\[\[' || true)
    single_bracket_count=$(grep -v '^#' install | grep -c '\[ ' || true)

    # We should have more [[ than [
    [[ "$double_bracket_count" -gt "$single_bracket_count" ]]
}

@test "install script uses proper quoting in loops" {
    # Check that variables in for loops are quoted
    ! grep -E 'for .* in \$[A-Za-z_].*\/\*;' install
}

@test "install script uses set -e or error handling" {
    # Should either use set -e or have explicit error handling
    # Our script uses || return and || exit patterns
    grep -q '|| return\||| exit' install
}

#######################################
# Documentation Tests
#######################################

@test "install script has header comments" {
    head -10 install | grep -q "Termieter"
}

@test "install script documents usage in comments" {
    head -20 install | grep -q "Usage:"
}

@test "functions have comments" {
    grep -B1 "^_print_h1()" install | grep -q "#"
}

#######################################
# Security Tests
#######################################

@test "install script does not use eval" {
    ! grep -q "eval" install
}

@test "install script quotes variables in critical operations" {
    # Check that rm commands have quoted variables
    grep "rm -rf" install | grep -q '"'
}

@test "install script does not expose credentials" {
    ! grep -iE "password|api[_-]?key|token|secret" install
}
