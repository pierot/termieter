#!/usr/bin/env bash
# 10-asdf — asdf version manager + Erlang/Elixir/Node/pnpm

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

SECTION_ID="10-asdf"
section_done "$SECTION_ID" && exit 0

banner "asdf + Erlang/Elixir/Node/pnpm" "🧰"

ASDF_DIR="$HOME/.asdf"
ASDF_VERSION="${ASDF_VERSION:-v0.14.1}"

STEP_TOTAL=6

# --- step 1: clone asdf ---
step "Install asdf $ASDF_VERSION"
if [[ -d "$ASDF_DIR/.git" ]]; then
  current=$(git -C "$ASDF_DIR" describe --tags 2>/dev/null || echo unknown)
  skip "asdf already cloned at $ASDF_DIR ($current)"
else
  if [[ "$DRY_RUN" == 1 ]]; then
    info "(dry-run) would clone asdf $ASDF_VERSION → $ASDF_DIR"
  else
    retry git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch "$ASDF_VERSION"
    ok "Cloned asdf $ASDF_VERSION"
  fi
fi

# --- step 2: wire into shell rc ---
step "Wire asdf into ~/.zshrc"
RC="$HOME/.zshrc"
ASDF_LINE='. "$HOME/.asdf/asdf.sh"'
if [[ -f "$RC" ]] && grep -qF "$ASDF_LINE" "$RC" 2>/dev/null; then
  skip "asdf already sourced in .zshrc"
else
  if confirm "Append asdf init lines to $RC?"; then
    if [[ "$DRY_RUN" == 1 ]]; then
      info "(dry-run) would append asdf init to $RC"
    else
      {
        echo ''
        echo '# asdf (added by stanley)'
        echo "$ASDF_LINE"
        echo 'fpath=(${ASDF_DIR}/completions $fpath)'
      } >> "$RC"
      ok "Appended to $RC"
    fi
  else
    warn "Skipped — you must source asdf manually for future sessions"
  fi
fi

# Source for this script so asdf commands work below
if [[ -f "$ASDF_DIR/asdf.sh" ]] && [[ "$DRY_RUN" == 0 ]]; then
  # shellcheck disable=SC1091
  . "$ASDF_DIR/asdf.sh"
fi

# --- helper: install a language plugin, falling back through candidates ---
#
# `asdf latest` returns the newest version tag, but the actual binary may not
# be published yet (e.g. hex.pm hasn't built the precompiled elixir zip for
# the latest -otp-N suffix). Strategy: try `latest`, then walk down the
# `list all` output until one installs cleanly.
install_lang() {
  local plugin=$1
  step "Install $plugin"

  if [[ "$DRY_RUN" == 1 ]]; then
    info "(dry-run) would: asdf plugin add $plugin && asdf install $plugin <latest-installable>"
    return 0
  fi

  if asdf plugin list 2>/dev/null | grep -qx "$plugin"; then
    skip "Plugin '$plugin' already added"
  else
    retry asdf plugin add "$plugin"
    ok "Added plugin: $plugin"
  fi

  # Build candidate list: top stable versions, newest first.
  local all_versions
  all_versions=$(asdf list all "$plugin" 2>/dev/null \
    | grep -E '^[0-9]+(\.[0-9]+)*(-otp-[0-9]+)?$' \
    | tail -10 \
    | tac)
  if [[ -z "$all_versions" ]]; then
    fail "Could not enumerate versions for $plugin (asdf list all returned nothing useful)"
    return 1
  fi

  # Ensure `asdf latest` is at the front if it's not already in the top 10.
  local latest candidates
  latest=$(asdf latest "$plugin" 2>/dev/null || true)
  if [[ -n "$latest" ]] && ! echo "$all_versions" | grep -qx "$latest"; then
    candidates="$latest"$'\n'"$all_versions"
  else
    candidates="$all_versions"
  fi

  local installed=""
  local attempts=0
  local max_attempts=4
  while IFS= read -r version; do
    [[ -z "$version" ]] && continue
    (( attempts >= max_attempts )) && break
    attempts=$((attempts + 1))

    if asdf list "$plugin" 2>/dev/null | grep -qx "$version"; then
      skip "$plugin $version already installed"
      installed=$version
      break
    fi

    info "Attempt ${attempts}/${max_attempts}: $plugin $version"
    if spin "Installing $plugin $version" asdf install "$plugin" "$version"; then
      installed=$version
      break
    fi
    warn "$plugin $version failed — falling back to next candidate"
  done <<<"$candidates"

  if [[ -z "$installed" ]]; then
    fail "Tried ${attempts} candidate(s) of $plugin — none installed cleanly"
    return 1
  fi

  asdf global "$plugin" "$installed"
  ok "$plugin $installed set as global default"
}

install_lang erlang
install_lang elixir
install_lang nodejs
install_lang rust

# --- step 6: pnpm ---
step "Install pnpm globally"
if [[ "$DRY_RUN" == 1 ]]; then
  info "(dry-run) would run: npm install -g pnpm"
elif has_cmd pnpm; then
  skip "pnpm already installed: $(pnpm --version)"
elif has_cmd npm; then
  retry npm install -g pnpm
  ok "pnpm installed: $(pnpm --version 2>/dev/null || echo '?')"
else
  warn "npm not on PATH — restart shell after asdf wires Node, then re-run with --force --only=10"
fi

mark_done "$SECTION_ID"
ok "Section complete: $SECTION_ID"
