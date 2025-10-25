#!/bin/bash
# Comprehensive verification script for termieter installation
# Tests that all expected files, symlinks, and configurations are in place

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Ensure USER is set (may not be in some Docker environments)
USER="${USER:-$(whoami)}"
export USER

# Test configuration
INSTALL_DIR="${HOME}/.termieter"
TEST_MODE="${TEST_MODE:-full}"  # full, update, or custom

#######################################
# Helper Functions
#######################################

print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_test() {
    echo -e "${YELLOW}TEST:${NC} $1"
}

assert_exists() {
    local path="$1"
    local description="${2:-$path}"
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking if $description exists"

    if [[ -e "$path" ]]; then
        echo -e "  ${GREEN}✓ PASS${NC}: $path exists"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}✗ FAIL${NC}: $path does not exist"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_not_exists() {
    local path="$1"
    local description="${2:-$path}"
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking if $description does not exist"

    if [[ ! -e "$path" ]]; then
        echo -e "  ${GREEN}✓ PASS${NC}: $path does not exist (as expected)"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}✗ FAIL${NC}: $path exists but should not"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_symlink() {
    local path="$1"
    local description="${2:-$path}"
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking if $description is a symlink"

    if [[ -L "$path" ]]; then
        local target=$(readlink "$path")
        echo -e "  ${GREEN}✓ PASS${NC}: $path is a symlink -> $target"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}✗ FAIL${NC}: $path is not a symlink"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_symlink_target() {
    local path="$1"
    local expected_target="$2"
    local description="${3:-$path}"
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking if $description points to correct target"

    if [[ -L "$path" ]]; then
        local target=$(readlink "$path")
        if [[ "$target" == "$expected_target" ]]; then
            echo -e "  ${GREEN}✓ PASS${NC}: $path -> $target (correct)"
            TESTS_PASSED=$((TESTS_PASSED + 1))
            return 0
        else
            echo -e "  ${RED}✗ FAIL${NC}: $path -> $target (expected: $expected_target)"
            TESTS_FAILED=$((TESTS_FAILED + 1))
            return 1
        fi
    else
        echo -e "  ${RED}✗ FAIL${NC}: $path is not a symlink"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_directory() {
    local path="$1"
    local description="${2:-$path}"
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking if $description is a directory"

    if [[ -d "$path" ]]; then
        echo -e "  ${GREEN}✓ PASS${NC}: $path is a directory"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}✗ FAIL${NC}: $path is not a directory"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_file() {
    local path="$1"
    local description="${2:-$path}"
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking if $description is a regular file"

    if [[ -f "$path" ]]; then
        echo -e "  ${GREEN}✓ PASS${NC}: $path is a file"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}✗ FAIL${NC}: $path is not a file"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_git_repo() {
    local path="$1"
    local description="${2:-$path}"
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking if $description is a git repository"

    if [[ -d "$path/.git" ]]; then
        echo -e "  ${GREEN}✓ PASS${NC}: $path is a git repository"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}✗ FAIL${NC}: $path is not a git repository"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_executable() {
    local path="$1"
    local description="${2:-$path}"
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking if $description is executable"

    if [[ -x "$path" ]]; then
        echo -e "  ${GREEN}✓ PASS${NC}: $path is executable"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}✗ FAIL${NC}: $path is not executable"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_file_contains() {
    local path="$1"
    local pattern="$2"
    local description="${3:-$path contains '$pattern'}"
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking if $description"

    if [[ -f "$path" ]] && grep -q "$pattern" "$path"; then
        echo -e "  ${GREEN}✓ PASS${NC}: Found pattern in $path"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}✗ FAIL${NC}: Pattern not found in $path"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

#######################################
# Test Suites
#######################################

test_installation_directory() {
    print_header "Testing Installation Directory"

    assert_exists "$INSTALL_DIR" "termieter installation directory"
    assert_directory "$INSTALL_DIR" "termieter installation directory"
    assert_git_repo "$INSTALL_DIR" "termieter installation"

    # Check key directories exist
    assert_exists "$INSTALL_DIR/symlinks" "symlinks directory"
    assert_exists "$INSTALL_DIR/users" "users directory"
}

test_backup_directory() {
    print_header "Testing Backup Directory"

    assert_exists "$HOME/.bash_backup" "backup directory"
    assert_directory "$HOME/.bash_backup" "backup directory"
}

test_symlinks() {
    print_header "Testing Symlinked Dotfiles"

    # Test that dotfiles are symlinks pointing to termieter
    # Note: We don't know exactly which files exist in symlinks/
    # So we'll test the pattern rather than specific files

    if [[ -d "$INSTALL_DIR/symlinks" ]]; then
        local symlink_count=0
        for file in "$INSTALL_DIR"/symlinks/*; do
            if [[ -f "$file" ]]; then
                local basename=$(basename "$file")
                local dotfile="$HOME/.$basename"

                if [[ -L "$dotfile" ]]; then
                    assert_symlink_target "$dotfile" "$file" ".$basename"
                    symlink_count=$((symlink_count + 1))
                fi
            fi
        done

        echo -e "\n${BLUE}INFO:${NC} Found $symlink_count symlinked dotfiles"
    fi
}

test_user_specific_files() {
    print_header "Testing User-Specific Configuration"

    local user_dir="$INSTALL_DIR/users/$USER"

    if [[ -d "$user_dir" ]]; then
        assert_exists "$user_dir" "user-specific directory"

        # Test .config symlink if it exists in user directory
        if [[ -d "$user_dir/config" ]]; then
            assert_symlink "$HOME/.config" ".config directory"
            assert_symlink_target "$HOME/.config" "$user_dir/config" ".config directory"
        fi

        # Test local files (these should have .local suffix)
        local locals=("base.sh" "vimrc.plugs" "vimrc" "gvimrc" "gitconfig" "zshrc" "tmux.conf")
        for local_file in "${locals[@]}"; do
            if [[ -f "$user_dir/$local_file" ]]; then
                local target="$HOME/.$local_file.local"
                if [[ -L "$target" ]]; then
                    assert_symlink_target "$target" "$user_dir/$local_file" ".$local_file.local"
                fi
            fi
        done
    else
        echo -e "${YELLOW}INFO:${NC} No user-specific directory found (this may be expected)"
    fi
}

test_tmux_plugins() {
    print_header "Testing tmux Plugins"

    if [[ -d "$INSTALL_DIR/tmux/tmux-resurrect" ]]; then
        assert_exists "$INSTALL_DIR/tmux/tmux-resurrect" "tmux-resurrect plugin"
        assert_directory "$INSTALL_DIR/tmux/tmux-resurrect" "tmux-resurrect plugin"
        assert_git_repo "$INSTALL_DIR/tmux/tmux-resurrect" "tmux-resurrect"
    else
        echo -e "${YELLOW}INFO:${NC} tmux-resurrect not installed (may not have been requested)"
    fi
}

test_git_configuration() {
    print_header "Testing Git Configuration"

    # Test that git config was set up correctly
    # Note: This is optional - may not be set in update mode
    local git_https_config=$(git config --global --get url.https://.insteadof || echo "")
    TESTS_RUN=$((TESTS_RUN + 1))

    print_test "Checking git HTTPS rewrite configuration"

    if [[ "$git_https_config" == "git://" ]]; then
        echo -e "  ${GREEN}✓ PASS${NC}: Git configured to use HTTPS instead of git://"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    elif [[ -z "$git_https_config" ]]; then
        echo -e "  ${YELLOW}⊘ SKIP${NC}: Git HTTPS rewrite not configured (may not be needed in update mode)"
        # Don't count as pass or fail - this is optional
        TESTS_RUN=$((TESTS_RUN - 1))
    else
        echo -e "  ${RED}✗ FAIL${NC}: Git HTTPS rewrite incorrectly configured: $git_https_config"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

test_starship() {
    print_header "Testing Starship (Optional)"

    TESTS_RUN=$((TESTS_RUN + 1))
    print_test "Checking if starship is installed"

    if command -v starship >/dev/null 2>&1; then
        echo -e "  ${GREEN}✓ PASS${NC}: Starship is installed"
        TESTS_PASSED=$((TESTS_PASSED + 1))

        # Show version
        local version=$(starship --version | head -1)
        echo -e "  ${BLUE}INFO:${NC} $version"
    else
        echo -e "  ${YELLOW}⊘ SKIP${NC}: Starship not installed (optional component)"
        # Don't count as pass or fail
        TESTS_RUN=$((TESTS_RUN - 1))
    fi
}

test_install_script_integrity() {
    print_header "Testing Install Script Integrity"

    assert_exists "$INSTALL_DIR/install" "install script"
    assert_file "$INSTALL_DIR/install" "install script"
    assert_executable "$INSTALL_DIR/install" "install script"
}

test_permissions() {
    print_header "Testing File Permissions"

    # Check that user owns the installation
    TESTS_RUN=$((TESTS_RUN + 1))
    print_test "Checking ownership of installation directory"

    local owner=$(stat -c '%U' "$INSTALL_DIR" 2>/dev/null || stat -f '%Su' "$INSTALL_DIR" 2>/dev/null)
    if [[ "$owner" == "$USER" ]]; then
        echo -e "  ${GREEN}✓ PASS${NC}: Installation owned by $USER"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "  ${RED}✗ FAIL${NC}: Installation owned by $owner (expected: $USER)"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

#######################################
# Main Test Execution
#######################################

print_header "🧪 Termieter Installation Verification"
echo -e "${BLUE}Test Mode:${NC} $TEST_MODE"
echo -e "${BLUE}Install Dir:${NC} $INSTALL_DIR"
echo -e "${BLUE}User:${NC} $USER"
echo -e "${BLUE}Home:${NC} $HOME"

# Run all test suites
test_installation_directory
test_backup_directory
test_symlinks
test_user_specific_files
test_tmux_plugins
test_git_configuration
test_starship
test_install_script_integrity
test_permissions

#######################################
# Summary
#######################################

print_header "📊 Test Summary"

echo -e "${BLUE}Tests Run:${NC}    $TESTS_RUN"
echo -e "${GREEN}Tests Passed:${NC} $TESTS_PASSED"
echo -e "${RED}Tests Failed:${NC} $TESTS_FAILED"

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓ ALL TESTS PASSED${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    exit 0
else
    echo -e "\n${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}✗ SOME TESTS FAILED${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    exit 1
fi
