#!/bin/bash
# Main test runner for termieter installation tests
# Orchestrates Docker tests, BATS tests, and shellcheck

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Test suite tracking
TOTAL_SUITES=0
PASSED_SUITES=0
FAILED_SUITES=0

# Test modes
RUN_SHELLCHECK=1
RUN_BATS=1
RUN_DOCKER=1
DOCKER_NO_CACHE=0

#######################################
# Helper Functions
#######################################

print_banner() {
    echo -e "\n${MAGENTA}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║${NC}  $1"
    echo -e "${MAGENTA}╚════════════════════════════════════════════════════════════╝${NC}\n"
}

print_section() {
    echo -e "\n${CYAN}┌────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│${NC}  $1"
    echo -e "${CYAN}└────────────────────────────────────────────────────────────┘${NC}\n"
}

print_result() {
    local status=$1
    local message=$2

    TOTAL_SUITES=$((TOTAL_SUITES + 1))

    if [[ $status -eq 0 ]]; then
        echo -e "${GREEN}✓ PASSED:${NC} $message"
        PASSED_SUITES=$((PASSED_SUITES + 1))
    else
        echo -e "${RED}✗ FAILED:${NC} $message"
        FAILED_SUITES=$((FAILED_SUITES + 1))
    fi
}

show_usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Run the complete termieter test suite including static analysis,
unit tests, and integration tests.

OPTIONS:
    -h, --help              Show this help message
    -s, --skip-shellcheck   Skip ShellCheck static analysis
    -b, --skip-bats         Skip BATS unit tests
    -d, --skip-docker       Skip Docker integration tests
    --no-cache              Build Docker images without cache
    --shellcheck-only       Run only ShellCheck
    --bats-only             Run only BATS tests
    --docker-only           Run only Docker integration tests

EXAMPLES:
    $(basename "$0")                    # Run all tests
    $(basename "$0") --skip-docker      # Run all except Docker tests
    $(basename "$0") --bats-only        # Run only BATS tests
    $(basename "$0") --no-cache         # Rebuild Docker images from scratch

REQUIREMENTS:
    - shellcheck (for static analysis)
    - bats-core (for unit tests)
    - docker (for integration tests)

INSTALL REQUIREMENTS:
    macOS:    brew install shellcheck bats-core docker
    Ubuntu:   apt-get install shellcheck bats docker.io
EOF
}

check_dependency() {
    local cmd=$1
    local name=$2
    local install_hint=$3

    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${YELLOW}⚠ WARNING:${NC} $name is not installed"
        echo -e "${BLUE}Install:${NC} $install_hint"
        return 1
    fi
    return 0
}

#######################################
# Parse Command Line Arguments
#######################################

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage
            exit 0
            ;;
        -s|--skip-shellcheck)
            RUN_SHELLCHECK=0
            shift
            ;;
        -b|--skip-bats)
            RUN_BATS=0
            shift
            ;;
        -d|--skip-docker)
            RUN_DOCKER=0
            shift
            ;;
        --no-cache)
            DOCKER_NO_CACHE=1
            shift
            ;;
        --shellcheck-only)
            RUN_SHELLCHECK=1
            RUN_BATS=0
            RUN_DOCKER=0
            shift
            ;;
        --bats-only)
            RUN_SHELLCHECK=0
            RUN_BATS=1
            RUN_DOCKER=0
            shift
            ;;
        --docker-only)
            RUN_SHELLCHECK=0
            RUN_BATS=0
            RUN_DOCKER=1
            shift
            ;;
        *)
            echo -e "${RED}Error:${NC} Unknown option: $1"
            echo "Run with --help for usage information"
            exit 1
            ;;
    esac
done

#######################################
# Main Test Execution
#######################################

print_banner "🧪 Termieter Test Suite"

echo -e "${BLUE}Project Root:${NC} $PROJECT_ROOT"
echo -e "${BLUE}Tests Directory:${NC} $SCRIPT_DIR"
echo -e "${BLUE}Test Configuration:${NC}"
echo -e "  ShellCheck: $([ $RUN_SHELLCHECK -eq 1 ] && echo 'Enabled' || echo 'Disabled')"
echo -e "  BATS Tests: $([ $RUN_BATS -eq 1 ] && echo 'Enabled' || echo 'Disabled')"
echo -e "  Docker Tests: $([ $RUN_DOCKER -eq 1 ] && echo 'Enabled' || echo 'Disabled')"

#######################################
# 1. ShellCheck Static Analysis
#######################################

if [[ $RUN_SHELLCHECK -eq 1 ]]; then
    print_section "1/3: Running ShellCheck Static Analysis"

    if check_dependency "shellcheck" "ShellCheck" "brew install shellcheck"; then
        if bash "$SCRIPT_DIR/shellcheck-test.sh"; then
            print_result 0 "ShellCheck analysis"
        else
            print_result 1 "ShellCheck analysis"
        fi
    else
        echo -e "${YELLOW}⊘ SKIPPED:${NC} ShellCheck not available\n"
    fi
fi

#######################################
# 2. BATS Unit Tests
#######################################

if [[ $RUN_BATS -eq 1 ]]; then
    print_section "2/3: Running BATS Unit Tests"

    if check_dependency "bats" "BATS" "brew install bats-core"; then
        # Run BATS tests from the project root so relative paths work
        cd "$PROJECT_ROOT"

        echo -e "${BLUE}Running BATS test suite...${NC}\n"

        if bats tests/install.bats; then
            print_result 0 "BATS unit tests"
        else
            print_result 1 "BATS unit tests"
        fi
    else
        echo -e "${YELLOW}⊘ SKIPPED:${NC} BATS not available"
        echo -e "${BLUE}Install:${NC} brew install bats-core"
        echo -e "${BLUE}Or:${NC} https://github.com/bats-core/bats-core#installation\n"
    fi
fi

#######################################
# 3. Docker Integration Tests
#######################################

if [[ $RUN_DOCKER -eq 1 ]]; then
    print_section "3/3: Running Docker Integration Tests"

    if check_dependency "docker" "Docker" "brew install docker"; then
        echo -e "${BLUE}Building Docker test image...${NC}\n"

        # Build Docker image
        DOCKER_BUILD_CMD="docker build -t termieter-test -f tests/Dockerfile ."

        if [[ $DOCKER_NO_CACHE -eq 1 ]]; then
            DOCKER_BUILD_CMD="$DOCKER_BUILD_CMD --no-cache"
            echo -e "${YELLOW}Building without cache (this may take a while)...${NC}\n"
        fi

        cd "$PROJECT_ROOT"

        if eval "$DOCKER_BUILD_CMD"; then
            echo -e "\n${GREEN}✓ Docker image built successfully${NC}\n"

            echo -e "${BLUE}Running installation in Docker container...${NC}\n"

            # Run the actual install script in the container
            # We'll run it in update mode to test without external git clone
            if docker run --rm termieter-test bash -c "
                cd /home/testuser/termieter-source && \
                cp -r . ~/.termieter && \
                cd ~/.termieter && \
                bash install -u && \
                bash tests/verify-installation.sh
            "; then
                print_result 0 "Docker integration tests"
            else
                print_result 1 "Docker integration tests"
                echo -e "\n${YELLOW}Tip:${NC} Run container interactively to debug:"
                echo -e "  docker run --rm -it termieter-test bash"
            fi
        else
            print_result 1 "Docker image build"
        fi
    else
        echo -e "${YELLOW}⊘ SKIPPED:${NC} Docker not available"
        echo -e "${BLUE}Install:${NC} brew install docker"
        echo -e "${BLUE}Or:${NC} https://docs.docker.com/get-docker/\n"
    fi
fi

#######################################
# Test Summary
#######################################

print_banner "📊 Test Summary"

echo -e "${BLUE}Total Test Suites:${NC} $TOTAL_SUITES"
echo -e "${GREEN}Passed:${NC} $PASSED_SUITES"
echo -e "${RED}Failed:${NC} $FAILED_SUITES"

if [[ $FAILED_SUITES -eq 0 ]] && [[ $TOTAL_SUITES -gt 0 ]]; then
    echo -e "\n${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                   ✓ ALL TESTS PASSED                       ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}\n"
    exit 0
elif [[ $TOTAL_SUITES -eq 0 ]]; then
    echo -e "\n${YELLOW}⚠ WARNING: No tests were run${NC}"
    echo -e "${YELLOW}Check that test dependencies are installed${NC}\n"
    exit 1
else
    echo -e "\n${RED}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                   ✗ SOME TESTS FAILED                      ║${NC}"
    echo -e "${RED}╚════════════════════════════════════════════════════════════╝${NC}\n"
    exit 1
fi
