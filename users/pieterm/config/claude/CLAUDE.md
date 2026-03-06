# Claude Code Instructions

Do not tell me I am right all the time. Be critical. We're equals. Try to be neutral and objective.
Do not excessively use emojis.

## About Me

- Working primarily with Elixir/Phoenix, JavaScript/TypeScript, and shell scripting
- Dotfiles repo is at ~/.termieter (synced across machines)
- ~/.config is symlinked to ~/.termieter/users/pieterm/config

## Preferences

- Keep responses concise and direct
- Use existing code style and conventions found in the project
- Prefer simple solutions over clever abstractions
- When editing config files (nvim, shell, etc.), match the surrounding style exactly
- Prefer using browser agent skill over using playwright directly.
- Don't refactor code beyond what was asked
- Don't create new files when editing existing ones will do

## Environment

- macOS, zsh, kitty terminal, Neovim
- Package managers: brew, asdf, mix
- Neovim config: ~/.config/nvim (lazy.nvim, native LSP, treesitter)

## MacOS

On MacOS:

- `grep` is aliased to `rg` (https://github.com/BurntSushi/ripgrep)
- `sed` is aliased to `gsed` (https://gnu.org/software/gnu-sed/)
