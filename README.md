# Terminal config files

Lean, fast terminal configuration for zsh with optional starship prompt.

## Quick Install

The installer will ask if you want to install starship prompt (recommended for best performance).

```bash
bash <( curl -s https://raw.githubusercontent.com/pierot/termieter/master/install )
```

## Installation Options

The installer can run interactively (with prompts) or non-interactively (with flags for automation).

```
Usage:          ./install [options]

Options:

  -h  --help           Show this message
  -u, --update         Update local setup (no cloning, no removing)
  -d, --directory      Install directory [~/.termieter]
  -s, --starship       Install starship prompt automatically (skip prompt)

Examples:

  # Interactive installation (recommended - will prompt for starship)
  bash <( curl -s https://raw.githubusercontent.com/pierot/termieter/master/install )

  # Non-interactive: Install with starship (no prompts)
  bash <( curl -s https://raw.githubusercontent.com/pierot/termieter/master/install ) -s

  # Non-interactive: Install without starship
  echo "n" | bash <( curl -s https://raw.githubusercontent.com/pierot/termieter/master/install )

  # Custom directory
  ./install -d ~/.my-terminal
```

## Features

- **40% faster startup** than previous oh-my-zsh-based setup (~107ms vs 177ms)
- **No oh-my-zsh dependency** - uses lean standalone plugins
- **Optimized fzf integration** with file previews using bat
- **Smart completion caching** - regenerates only once per day
- **Optional starship prompt** - blazing fast, cross-shell compatible
- **Shared configuration** - `zsh/common.sh` works for all users

## Performance

- Startup time: ~107ms (with starship)
- Lazy-loaded completions
- Optimized history management
- Async command suggestions (when available)

# Vim config

See https://github.com/jackjoe/vim
