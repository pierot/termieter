# Termieter Installation Tests

Comprehensive test suite for the termieter installation script, providing safe and isolated testing before making changes to your system.

## Overview

This test suite provides three layers of testing:

1. **Static Analysis (ShellCheck)** - Catches common bash scripting issues
2. **Unit Tests (BATS)** - Tests individual functions and script behavior
3. **Integration Tests (Docker)** - Full end-to-end installation in an isolated container

## Quick Start

### Prerequisites

Install the required testing tools:

```bash
# macOS
brew install shellcheck bats-core docker

# Ubuntu/Debian
apt-get install shellcheck bats docker.io

# Or install individually - see links below
```

### Run All Tests

```bash
cd /path/to/termieter
./tests/run-all-tests.sh
```

## Test Components

### 1. ShellCheck Static Analysis

**What it does:** Analyzes the bash script for common errors, style issues, and potential bugs without executing it.

**Run individually:**
```bash
./tests/shellcheck-test.sh
```

**What it checks:**
- Syntax errors
- Unquoted variables
- Unreachable code
- Common scripting mistakes
- Style and best practices

### 2. BATS Unit Tests

**What it does:** Tests individual functions, option parsing, and script logic in isolation.

**Run individually:**
```bash
cd /path/to/termieter
bats tests/install.bats
```

**What it tests:**
- Command-line option parsing
- Help text and usage
- Function behavior (`_contains_element`, etc.)
- Color code definitions
- Git configuration
- Symlink creation logic
- Error handling
- Code quality patterns

**Test file:** `tests/install.bats`

### 3. Docker Integration Tests

**What it does:** Runs the complete installation in an isolated Ubuntu container and verifies the result.

**Run individually:**
```bash
cd /path/to/termieter

# Build test image
docker build -t termieter-test -f tests/Dockerfile .

# Run installation and verification
docker run --rm termieter-test
```

**What it verifies:**
- Installation directory structure
- Git repository cloning
- Symlink creation and targets
- Backup directory creation
- User-specific configurations
- .config directory setup
- tmux plugin installation
- File permissions
- Git configuration

**Files:**
- `tests/Dockerfile` - Test environment definition
- `tests/verify-installation.sh` - Comprehensive verification script

## Usage Examples

### Run All Tests
```bash
./tests/run-all-tests.sh
```

### Run Only ShellCheck
```bash
./tests/run-all-tests.sh --shellcheck-only
```

### Run Only BATS Tests
```bash
./tests/run-all-tests.sh --bats-only
```

### Run Only Docker Tests
```bash
./tests/run-all-tests.sh --docker-only
```

### Skip Docker Tests (faster)
```bash
./tests/run-all-tests.sh --skip-docker
```

### Rebuild Docker Image Without Cache
```bash
./tests/run-all-tests.sh --no-cache
```

### Show Help
```bash
./tests/run-all-tests.sh --help
```

## Docker Testing Details

### Test Environment

The Docker tests use Ubuntu 22.04 with:
- Git, zsh, curl, vim, tmux installed
- Non-root test user (`testuser`)
- Clean home directory
- Git configuration for test user

### Interactive Docker Testing

For debugging, you can run the container interactively:

```bash
# Build the image
docker build -t termieter-test -f tests/Dockerfile .

# Run interactively
docker run --rm -it termieter-test bash

# Inside the container
cd /home/testuser/termieter-source
./install -d ~/.termieter-test
./tests/verify-installation.sh
```

### What Gets Tested

The Docker integration tests verify:

**✓ Directory Structure**
- Installation directory exists and is a git repo
- Backup directory created
- Proper directory permissions

**✓ Symlinks**
- All dotfiles properly symlinked
- Symlinks point to correct targets
- User-specific files handled correctly

**✓ Configuration**
- .config directory symlinked
- Local files (`.local` suffix) created for user customization
- tmux plugins cloned

**✓ Git Configuration**
- HTTPS rewrite configured
- Repository cloned successfully

**✓ Permissions**
- Files owned by correct user
- Install script is executable

## Verification Script

The verification script (`tests/verify-installation.sh`) can also be run standalone after a manual installation:

```bash
# After running install on your system
./tests/verify-installation.sh
```

This helps verify that your real installation is correct.

## Test Output

### Successful Test Run
```
╔════════════════════════════════════════════════════════════╗
║  🧪 Termieter Test Suite
╚════════════════════════════════════════════════════════════╝

┌────────────────────────────────────────────────────────────┐
│  1/3: Running ShellCheck Static Analysis
└────────────────────────────────────────────────────────────┘

✓ PASSED: ShellCheck analysis

┌────────────────────────────────────────────────────────────┐
│  2/3: Running BATS Unit Tests
└────────────────────────────────────────────────────────────┘

✓ PASSED: BATS unit tests

┌────────────────────────────────────────────────────────────┐
│  3/3: Running Docker Integration Tests
└────────────────────────────────────────────────────────────┘

✓ PASSED: Docker integration tests

╔════════════════════════════════════════════════════════════╗
║                   ✓ ALL TESTS PASSED                       ║
╚════════════════════════════════════════════════════════════╝
```

## Continuous Integration

These tests are designed to be run in CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Run Tests
  run: |
    ./tests/run-all-tests.sh
```

## Troubleshooting

### "shellcheck: command not found"
Install ShellCheck:
```bash
brew install shellcheck  # macOS
apt-get install shellcheck  # Ubuntu
```

### "bats: command not found"
Install BATS:
```bash
brew install bats-core  # macOS
git clone https://github.com/bats-core/bats-core.git && cd bats-core && ./install.sh /usr/local
```

### "docker: command not found"
Install Docker:
```bash
brew install docker  # macOS
# Or visit: https://docs.docker.com/get-docker/
```

### Docker Tests Fail
Try rebuilding without cache:
```bash
./tests/run-all-tests.sh --no-cache
```

Run interactively to debug:
```bash
docker run --rm -it termieter-test bash
```

### BATS Tests Can't Find Functions
Make sure you're running BATS from the project root:
```bash
cd /path/to/termieter
bats tests/install.bats
```

## Adding New Tests

### Add BATS Test
Edit `tests/install.bats`:
```bash
@test "description of your test" {
    # Test code here
    run some_command
    [[ "$status" -eq 0 ]]
    [[ "$output" =~ "expected pattern" ]]
}
```

### Add Verification Check
Edit `tests/verify-installation.sh`:
```bash
test_your_feature() {
    print_header "Testing Your Feature"

    assert_exists "/path/to/file" "your feature"
    assert_symlink "$HOME/.yourfile" "your dotfile"
}

# Add to main execution
test_your_feature
```

## Test Philosophy

1. **No Side Effects** - Tests never modify your real system
2. **Reproducible** - Same results every time
3. **Fast Feedback** - Quick unit tests, slower integration tests
4. **Comprehensive** - Multiple layers catch different issues
5. **Easy to Run** - Single command for all tests

## Links

- [ShellCheck](https://github.com/koalaman/shellcheck)
- [BATS](https://github.com/bats-core/bats-core)
- [Docker](https://www.docker.com/)

## License

Same as termieter project.
