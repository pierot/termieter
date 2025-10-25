#!/bin/bash
# ShellCheck integration test for termieter install script
# Runs shellcheck with appropriate configuration and reports issues

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SCRIPT="$SCRIPT_DIR/../install"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}ShellCheck Analysis for install script${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Check if shellcheck is installed
if ! command -v shellcheck >/dev/null 2>&1; then
    echo -e "${YELLOW}⚠ WARNING:${NC} shellcheck is not installed"
    echo -e "${YELLOW}Install with:${NC}"
    echo -e "  macOS:  brew install shellcheck"
    echo -e "  Ubuntu: apt-get install shellcheck"
    echo -e "  Other:  https://github.com/koalaman/shellcheck#installing\n"
    exit 1
fi

# Show shellcheck version
SHELLCHECK_VERSION=$(shellcheck --version | grep "^version:" | awk '{print $2}')
echo -e "${BLUE}ShellCheck Version:${NC} $SHELLCHECK_VERSION\n"

# Check if install script exists
if [[ ! -f "$INSTALL_SCRIPT" ]]; then
    echo -e "${RED}✗ ERROR:${NC} Install script not found at: $INSTALL_SCRIPT"
    exit 1
fi

echo -e "${BLUE}Analyzing:${NC} $INSTALL_SCRIPT\n"

# Run shellcheck with specific configuration
# SC2059: Don't use variables in printf format string (we accept this for color codes)
# SC2086: Double quote to prevent globbing (we accept this in some cases)
# SC2119/SC2120: Function references arguments but none passed (acceptable for our usage function)

echo -e "${YELLOW}Running ShellCheck...${NC}\n"

# Capture shellcheck output
SHELLCHECK_OUTPUT=$(shellcheck \
    --exclude=SC2059,SC2086,SC2119,SC2120 \
    --severity=style \
    --format=gcc \
    "$INSTALL_SCRIPT" 2>&1) || SHELLCHECK_EXIT=$?

# Check if there were any issues
if [[ -z "$SHELLCHECK_OUTPUT" ]]; then
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓ PASSED: No ShellCheck issues found!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    exit 0
else
    # Parse and categorize issues
    ERROR_COUNT=$(echo "$SHELLCHECK_OUTPUT" | grep -c "error:" || true)
    WARNING_COUNT=$(echo "$SHELLCHECK_OUTPUT" | grep -c "warning:" || true)
    INFO_COUNT=$(echo "$SHELLCHECK_OUTPUT" | grep -c "info:" || true)
    STYLE_COUNT=$(echo "$SHELLCHECK_OUTPUT" | grep -c "style:" || true)

    echo -e "${BLUE}Issues Found:${NC}"
    echo -e "  ${RED}Errors:${NC}   $ERROR_COUNT"
    echo -e "  ${YELLOW}Warnings:${NC} $WARNING_COUNT"
    echo -e "  ${BLUE}Info:${NC}     $INFO_COUNT"
    echo -e "  ${BLUE}Style:${NC}    $STYLE_COUNT\n"

    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}ShellCheck Output:${NC}\n"
    echo "$SHELLCHECK_OUTPUT"
    echo ""

    # Provide helpful information
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}For more information about specific issues:${NC}"
    echo -e "  https://github.com/koalaman/shellcheck/wiki\n"

    # Exit with error if there are errors, warning if there are warnings
    if [[ $ERROR_COUNT -gt 0 ]]; then
        echo -e "${RED}✗ FAILED: Found $ERROR_COUNT error(s)${NC}\n"
        exit 1
    elif [[ $WARNING_COUNT -gt 0 ]]; then
        echo -e "${YELLOW}⚠ WARNINGS: Found $WARNING_COUNT warning(s)${NC}"
        echo -e "${YELLOW}Consider addressing these before deploying${NC}\n"
        exit 0  # Don't fail on warnings
    else
        echo -e "${BLUE}ℹ INFO: Found $(($INFO_COUNT + $STYLE_COUNT)) informational message(s)${NC}"
        echo -e "${BLUE}These are suggestions for improvement${NC}\n"
        exit 0
    fi
fi
