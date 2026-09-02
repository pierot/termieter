# Claude Instructions

- Do not tell me I am right all the time. Be critical. We're equals.
- Try to be neutral and objective.
- Do not excessively use emojis.
- No preamble. No "Great question!", "Sure!", "Of course!", "Certainly!", "Absolutely!".
- No hollow closings. No "I hope this helps!", "Let me know if you need anything!".
- Structured output is preferred: bullets, tables, code blocks.
- Compress responses. Every sentence must earn its place.
- No long intros or transitions between sections.
- Use `ASD-STE100 Simplified Technical English` as much as possible without losing detail.

## Code / Coding

Important: never start editing or implementing immediately! Always start with a plan and ask before execution!

Important: NEVER run `git commit` or `git push` unless I explicitly ask for it in my own words.
Approving a plan that mentions committing/pushing does NOT count as explicit approval — always ask again right before committing or pushing.

### Planning strategy

- Always work with a plan of actions and present this plan to me before going into execution mode.
- A plan consists of a good analysis of the context and problem, followed by a plan of actions.
- Each step (or set of steps) has a verification/testing method.
- Each step can be marked as done when finished.
- The instruction `Investigate thoroughly, analyse with hard and deep thinking and propose plan of action with todos.` is a good starting point.

### About Me

- Working primarily with Elixir/Phoenix, JavaScript/TypeScript, and shell scripting
- Dotfiles repo is at ~/.termieter (synced across machines)
- ~/.config is symlinked to ~/.termieter/users/pieterm/config

### Preferences

- Never speculate about code, files, or APIs you have not read.
- Use existing code style and conventions found in the project.
- Prefer simple solutions over clever abstractions.
- When editing files, match the surrounding style exactly.
- Don't refactor code beyond what was asked.
- Don't create new files when editing existing ones will do.
- No symlinks in coding projects. In config/dotfiles projects (e.g. ~/.termieter) symlinks are fine.
- Prefer using browser agent skill over using playwright directly.
- When using Playwright MCP, prefer Firefox (cfr self signed certs).
- Fancy algorithms are buggier than simple ones, and they're much harder to implement. Use simple algorithms as well as simple data structures.
- Data dominates. If you've chosen the right data structures and organized things well, the algorithms will almost always be self-evident. Data structures, not algorithms, are central to programming.

### Testing

- Use the existing testing methods and tools from the project you are working in.

### Environment

- macOS, zsh, kitty terminal, Neovim
- Package managers: brew, asdf, mix
- Neovim config: ~/.config/nvim (lazy.nvim, native LSP, treesitter)

### Tools / CLI

Use these tools extensively:

- `rtk` if available always use it to run other toolt
- `jq` you can use it to inspect json files or parse/inspect json output of other tools.
- `ripgrep` faster grep tool
- `fd` faster than `find`
  = `wt` (worktrunk) for working with git worktrees

### ctx (agent history search)

`ctx` indexes all local coding-agent sessions (Claude Code, Codex, OpenCode) into a searchable store at `~/.ctx`.

- At the start of a non-trivial task, investigation, or bug report: search prior sessions first with `ctx search "<topic>"`. Add `--term "<variant>"` terms when wording is uncertain, `--workspace <name>` to scope.
- Inspect the best match before relying on it: `ctx show event <ctx-event-id> --window 3` or `ctx show session <ctx-session-id>`.
- Cite the `ctx_event_id` / `ctx_session_id` when retrieved history influenced the answer.
- Use `--refresh off` for strictly read-only queries.
- Division of labor: ctx = verbatim recall of past sessions; file-based memory = curated decisions and preferences. Check both; do not copy into memory what ctx already holds.

### MacOS

On MacOS:

- `grep` is aliased to `rg` (https://github.com/BurntSushi/ripgrep)
- `sed` is aliased to `gsed` (https://gnu.org/software/gnu-sed/)

### RTK - Rust Token Killer

**Usage**: Token-optimized CLI proxy (60-90% savings on dev operations)

#### Meta Commands (always use rtk directly)

```bash
rtk gain              # Show token savings analytics
rtk gain --history    # Show command usage history with savings
rtk discover          # Analyze Claude Code history for missed opportunities
rtk proxy <cmd>       # Execute raw command without filtering (for debugging)
```

#### Installation Verification

```bash
rtk --version         # Should show: rtk X.Y.Z
rtk gain              # Should work (not "command not found")
which rtk             # Verify correct binary
```

⚠️ **Name collision**: If `rtk gain` fails, you may have reachingforthejack/rtk (Rust Type Kit) installed instead.

#### Hook-Based Usage

All other commands are automatically rewritten by the Claude Code hook.
Example: `git status` → `rtk git status` (transparent, 0 tokens overhead)
