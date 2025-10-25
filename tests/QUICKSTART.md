# Quick Start: Testing Your Install Script Changes

This guide shows you how to safely test changes to the `install` script before running it on your real system.

## The Problem

You want to modify the `install` script, but running it directly could:
- Overwrite your existing dotfiles
- Break your current setup
- Be difficult to undo

## The Solution

Use our isolated Docker-based testing environment!

## Step 1: Make Your Changes

Edit the `install` script:
```bash
vim install  # or your favorite editor
```

## Step 2: Run Static Analysis

Check for syntax errors and common issues:
```bash
./tests/shellcheck-test.sh
```

This runs instantly and catches most mistakes.

## Step 3: Run Unit Tests (Optional)

If you have BATS installed:
```bash
bats tests/install.bats
```

Install BATS:
```bash
brew install bats-core  # macOS
```

## Step 4: Run Integration Test

Test the complete installation in an isolated Docker container:

```bash
# Build test image and run tests
docker build -t termieter-test -f tests/Dockerfile . && \
docker run --rm termieter-test
```

This will:
1. Create a clean Ubuntu container
2. Install all dependencies
3. Run your modified install script
4. Verify everything was installed correctly
5. Show you detailed results
6. Clean up automatically

## Step 5: Review Results

You'll see output like:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🧪 Termieter Installation Verification
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Testing Installation Directory
✓ PASS: /home/testuser/.termieter exists
✓ PASS: /home/testuser/.termieter is a directory
✓ PASS: /home/testuser/.termieter is a git repository

Testing Symlinked Dotfiles
✓ PASS: .bashrc -> correct target

... (more tests)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ ALL TESTS PASSED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Step 6: Debug If Needed

If tests fail, run the container interactively:

```bash
docker run --rm -it termieter-test bash
```

Inside the container:
```bash
cd /home/testuser/termieter-source
./install -d ~/.termieter-test
# Check what went wrong
ls -la ~
ls -la ~/.termieter-test
```

## Step 7: Run All Tests Together

Once everything passes, run the complete suite:

```bash
./tests/run-all-tests.sh
```

This runs:
- ShellCheck (static analysis)
- BATS tests (unit tests)
- Docker tests (integration tests)

## One-Line Test Command

For quick testing after changes:

```bash
./tests/shellcheck-test.sh && docker build -t termieter-test -f tests/Dockerfile . && docker run --rm termieter-test
```

## Common Workflows

### Just Changed a Function?
```bash
./tests/shellcheck-test.sh
bats tests/install.bats  # if installed
```

### Changed Installation Logic?
```bash
docker build -t termieter-test -f tests/Dockerfile . && \
docker run --rm termieter-test
```

### Ready to Commit?
```bash
./tests/run-all-tests.sh
```

## When to Test on Your Real System

Only after:
1. ✓ All Docker tests pass
2. ✓ You've reviewed the verification output
3. ✓ You've backed up your dotfiles:
   ```bash
   tar -czf ~/dotfiles-backup-$(date +%Y%m%d).tar.gz \
     ~/.termieter ~/.bashrc ~/.zshrc ~/.config
   ```

Then test with update mode first:
```bash
./install -u  # update mode, doesn't remove existing
```

## Need Help?

- See `tests/README.md` for detailed documentation
- Run `./tests/run-all-tests.sh --help` for options
- Check Docker logs if something fails
- Run container interactively to debug

## Pro Tips

1. **Use `--no-cache` if you changed the Dockerfile:**
   ```bash
   ./tests/run-all-tests.sh --no-cache
   ```

2. **Skip slow Docker tests during development:**
   ```bash
   ./tests/run-all-tests.sh --skip-docker
   ```

3. **Only run Docker tests before committing:**
   ```bash
   ./tests/run-all-tests.sh --docker-only
   ```

4. **Test different scenarios:**
   ```bash
   # Test fresh install
   docker run --rm termieter-test

   # Test with starship
   docker run --rm termieter-test bash -c "
     cd ~/termieter-source && ./install -d ~/.termieter -s
   "
   ```

## That's It!

You now have a safe, isolated environment to test any changes to your install script. No more crossing your fingers and hoping it works! 🎉
