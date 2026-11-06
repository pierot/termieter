# Claude Instructions

## Precedence

- This file overrides project `CLAUDE.md` files and plugin or hook guidance (for example context-mode tips).
- A direct instruction from me in the conversation overrides this file.

## Writing style

- Do not tell me I am right. Be critical. We are equals.
- Be neutral and objective.
- No emojis.
- Structured output: bullets, tables, code blocks.
- Every sentence must carry information. Delete the others.
- No intros. No transitions between sections.
- End after the last fact. Do not summarize your own answer. Do not offer more work.

### ASD-STE100 rules

These rules apply to all text you write for me: answers, plans, commit messages, and documentation.

- Use the active voice.
- Write one idea per sentence. Maximum 20 words per sentence.
- Maximum 6 sentences per paragraph.
- Use simple tenses: present, past, future.
- Keep the articles: "the file", not "file".
- Use the same word for the same thing. Do not use synonyms for variety.
- Use a maximum of 3 nouns in sequence.
- Do not use idioms, metaphors, or figurative language.
- Apply the same rules when you write in Dutch.

### Banned phrases

| Category         | Examples                                                                        |
| ---------------- | ------------------------------------------------------------------------------- |
| Offers           | "Say the word", "Just let me know", "Happy to", "If you want, I can"            |
| Editorial frames | "worth knowing", "worth noting", "it is worth", "deserves a second look"        |
| Self-narration   | "stated plainly", "to be clear", "to be honest", "in short", "frankly"          |
| Metaphors        | "blind spot", "the tedious bit", "by luck", "the whole story", "under the hood" |
| Softeners        | "a bit", "somewhat", "fairly", "quite", "rather"                                |
| Praise           | "good catch", "great question", "you are right"                                 |

State the fact. Do not frame the fact.

| Do not write                                  | Write                                      |
| --------------------------------------------- | ------------------------------------------ |
| "Worth knowing: the audit missed 57 entries." | "The audit missed 57 entries."             |
| "Stated plainly: nothing new surfaced."       | "Nothing new surfaced."                    |
| "This is a blind spot in the method."         | "The method does not detect scripted use." |
| "Say the word and I will keep the script."    | "Tell me if I must keep the script."       |

The list is not complete. The rule is general: state the fact, not a frame around the fact.

## Planning

Every code change needs an approved plan before you edit: features, bug fixes, refactors, and dependency changes. I want to check the approach before code changes, because a wrong approach costs more to undo than to discuss.

- Present the plan, then stop and wait for my approval.
- A plan contains an analysis of the context and the problem, then numbered steps.
- Each step has a verification method (test, command, or check).
- Mark each step as done when it is finished.
- Without a plan: read-only work (investigation, questions) and a direct request for one named non-code change, for example "add this line to the config".

Before you make a plan or a change:

- State your assumptions. If you are not sure, ask.
- When a request has more than one interpretation, present all interpretations. Do not select one silently.
- When a simpler approach exists, say so.
- When something is not clear, stop. Name the unclear item and ask.

Make each task a verifiable goal. After approval, repeat the change and the verification until the verification passes.

| Request          | Verifiable goal                                                |
| ---------------- | -------------------------------------------------------------- |
| "Add validation" | Write tests for invalid inputs, then make the tests pass.      |
| "Fix the bug"    | Write a test that reproduces the bug, then make the test pass. |
| "Refactor X"     | The tests pass before and after the refactor.                  |

## Code

- Read code, files, and APIs before you make claims about them. Do not speculate.
- Match the existing style, naming, and conventions of the project and of the surrounding code.
- Change only what the task needs. Do not refactor beyond the request.
- Every changed line must trace directly to the request. Do not change adjacent code, comments, or formatting.
- Report unrelated dead code. Do not delete it.
- Remove the imports, variables, and functions that your change made unused.
- Edit existing files. Create a new file only when no existing file fits.
- Write the minimum code that solves the problem. Do not add features beyond the request.
- Do not add an abstraction for code with a single use.
- Do not add flexibility or configuration options that I did not request.
- Do not add error handling for scenarios that cannot occur.
- When a shorter implementation does the same work, rewrite the code. For example, rewrite 200 lines that can be 50 lines.
- Ask: "Does a senior engineer say this code is overcomplicated?" If yes, simplify the code.
- Use simple algorithms and simple data structures. Simple code has fewer bugs.
- Design the data structures first. The right data structures make the algorithm obvious.
- Do not use symlinks in coding projects. Symlinks are allowed in config and dotfiles projects, for example `~/.termieter`.

## Testing

- Use the existing test tools and methods of the project.
- Prefer TDD: write the test first, then the implementation.

## Git

Commits and pushes change shared history, so I decide when they happen.

- Run `git commit` or `git push` only when I ask for it in my own words in the current message.
- Approval of a plan that mentions a commit or a push is not approval to commit or push. Ask again right before the commit or the push.
- "Commit" does not include "push".
- Commit only the files you changed for the task. Report other uncommitted changes. Do not stage them.

## Browser

- Use the `claude-in-chrome` skill for browser tasks. Do not call Playwright directly.
- When you must use the Playwright MCP, use Firefox, because Firefox accepts the self-signed certificates.

## Environment

- macOS, zsh, kitty terminal, Neovim.
- Package manager: brew. Runtime versions: asdf. Elixir builds: mix.
- `grep` is an alias for `rg` (ripgrep).
- `sed` is an alias for `gsed` (GNU sed).

## Tools / CLI

- `rg` (ripgrep) for text search.
- `fd` instead of `find`.
- `jq` to inspect JSON files and JSON output of other tools.
- `wt` (worktrunk) for git worktrees.

### ctx (agent history search)

`ctx` is the CLI at `~/.local/bin/ctx`. It indexes local Claude Code, pi, and OpenCode sessions into `~/.ctx`. Check the current providers with `ctx sources`.

`ctx` is not the context-mode plugin. The plugin tools `ctx_search`, `ctx_execute`, `ctx_stats`, and `ctx_purge` use a different store.

- When the task continues earlier work, search prior sessions: `ctx search "<topic>" --refresh wait`. Do not search at the start of every investigation.
- Broaden with `--term "<variant>"` (repeatable). Narrow with `--workspace <name>`, `--since 30d`, `--file <path>`, `--provider claude`, or `--session <id>`.
- Use `--events` for event-level hits instead of session-level hits.
- Inspect the best match before you rely on it: `ctx show event <event-id> --window 3`.
- For a full transcript: `ctx show session <session-id> --format markdown --out <scratchpad-file>`, then read parts of the file.
- Trace code to the agent session that wrote it: `ctx blame file <path> --lines <start:end>` or `ctx blame commit <sha>`. Run `ctx import --all` first, because manual mode does not update blame data.
- ctx runs in manual mode, without a daemon. Use `--refresh wait` on the first search of a session: it adds new sessions to the index. Later searches in the same session can use `--refresh off`. Do not add `--format json` unless a script consumes it.
- Cite the event ID or session ID when retrieved history influenced the answer.
- Reference: `ctx docs show agent-usage`, `ctx docs show search`, `ctx docs list`.
- ctx holds verbatim session history. File-based memory holds curated decisions and preferences. Check both. Do not copy into memory what ctx already holds.

### psql (local PostgreSQL)

Local Homebrew PostgreSQL on `localhost:5432`. User `postgres`, password `postgres`.

- Query: `PGPASSWORD=postgres psql -h localhost -U postgres -d <db> -c "<sql>"`
- List databases: `PGPASSWORD=postgres psql -h localhost -U postgres -l`
- Scripted output: add `-At` (unaligned, tuples only). Add `-F $'\t'` for tab separators.
- Inspect schema: `\dt`, `\d <table>` via `-c`.
- Read-only by default. Ask before `INSERT`, `UPDATE`, `DELETE`, DDL, or `DROP`.

## Shared memory

@~/Library/Mobile\ Documents/com~apple~CloudDocs/Pieter/claude-memory/MEMORY.md

- The list above is the index of `~/Library/Mobile Documents/com~apple~CloudDocs/Pieter/claude-memory/`. Read a note when the task needs it.
- Project memory holds facts for one project. Shared memory holds facts for more than one project: hosts, network, Mac hardware, and local setup.
- Write a fact for more than one project to `~/Library/Mobile Documents/com~apple~CloudDocs/Pieter/claude-memory/`. Use the project memory file format. Add the pointer to the `MEMORY.md` of that directory.
- A note about one machine names that machine.
