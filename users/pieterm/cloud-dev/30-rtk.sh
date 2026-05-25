#!/usr/bin/env bash
# 30-rtk — RTK (Rust Token Killer) from rtk-ai/rtk
# Tries cargo install first, falls back to GitHub release binary.

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

SECTION_ID="30-rtk"
section_done "$SECTION_ID" && exit 0

banner "RTK — Rust Token Killer" "🦀"

RTK_REPO="https://github.com/rtk-ai/rtk"
RTK_OWNER="rtk-ai"
RTK_NAME="rtk"

STEP_TOTAL=4

# --- step 1: detect existing rtk (and disambiguate from the namesake) ---
step "Check existing rtk installation"
if has_cmd rtk; then
  current_path=$(command -v rtk)
  if rtk gain >/dev/null 2>&1; then
    ok "Working rtk-ai/rtk already installed at $current_path"
    skip "Nothing to do"
    mark_done "$SECTION_ID"
    exit 0
  fi
  warn "rtk found at $current_path but 'rtk gain' fails"
  warn "This is likely 'reachingforthejack/rtk' (Rust Type Kit), not 'rtk-ai/rtk'"
  if ! confirm "Continue and install rtk-ai/rtk alongside / over it?"; then
    info "Skipping by user request"
    exit 0
  fi
fi

# --- step 2: install via cargo if available ---
step "Try cargo install --git $RTK_REPO"
install_from_release=1
if has_cmd cargo; then
  if [[ "$DRY_RUN" == 1 ]]; then
    info "(dry-run) would run: cargo install --git $RTK_REPO --locked"
    install_from_release=0
  else
    if spin "Building rtk via cargo" cargo install --git "$RTK_REPO" --locked; then
      ok "Installed via cargo"
      install_from_release=0
    else
      warn "cargo install failed (repo may not be a buildable cargo crate at root) — falling back to release binary"
    fi
  fi
else
  info "cargo not on PATH — skipping to release-binary install"
fi

# --- step 3: fallback to GitHub release binary ---
if (( install_from_release == 1 )); then
  step "Download latest release binary"

  if [[ "$DRY_RUN" == 1 ]]; then
    info "(dry-run) would fetch latest linux-x86_64 release from $RTK_REPO/releases"
  else
    api="https://api.github.com/repos/$RTK_OWNER/$RTK_NAME/releases/latest"
    info "Querying GitHub API: $api"

    # Get release JSON (handles rate-limit failure gracefully)
    release_json=$(retry curl -fsSL -H "Accept: application/vnd.github+json" "$api") || {
      fail "Could not query GitHub releases API"
      info "Manual install: visit $RTK_REPO/releases and follow upstream instructions"
      exit 1
    }

    # Find a linux x86_64 asset
    asset_url=$(echo "$release_json" \
      | jq -r '.assets[]?.browser_download_url
               | select(test("linux.*x86_64|x86_64.*linux|linux.*amd64|amd64.*linux"; "i"))' \
      | head -1)

    if [[ -z "$asset_url" || "$asset_url" == "null" ]]; then
      fail "No linux x86_64 asset found in latest release"
      info "Release assets present:"
      echo "$release_json" | jq -r '.assets[]?.name' | sed 's/^/    /' | tee -a "$INSTALL_LOG" >&2 || true
      info "Manual install: $RTK_REPO/releases"
      exit 1
    fi

    info "Asset URL: $asset_url"
    tmp=$(mktemp -d)
    trap 'rm -rf "$tmp"' RETURN
    archive="$tmp/rtk.bin"
    retry curl -fsSL -o "$archive" "$asset_url"

    case "$asset_url" in
      *.tar.gz|*.tgz) tar -xzf "$archive" -C "$tmp" ;;
      *.tar.xz)       tar -xJf "$archive" -C "$tmp" ;;
      *.zip)          unzip -q "$archive" -d "$tmp" ;;
      *)              # Assume raw binary
                      mv "$archive" "$tmp/rtk"
                      chmod +x "$tmp/rtk"
                      ;;
    esac

    bin=$(find "$tmp" -type f \( -name rtk -o -name "rtk-*" \) -executable 2>/dev/null | head -1)
    if [[ -z "$bin" ]]; then
      # Try without -executable in case extracted bits lack the bit
      bin=$(find "$tmp" -type f \( -name rtk -o -name "rtk-*" \) | head -1)
      [[ -n "$bin" ]] && chmod +x "$bin"
    fi

    if [[ -z "$bin" ]]; then
      fail "rtk binary not found in extracted archive"
      info "Contents of $tmp:"
      find "$tmp" | sed 's/^/    /' | tee -a "$INSTALL_LOG" >&2
      exit 1
    fi

    mkdir -p "$HOME/.local/bin"
    install -m 0755 "$bin" "$HOME/.local/bin/rtk"
    ok "Installed: ~/.local/bin/rtk"
  fi
fi

# --- step 4: verify ---
step "Verify rtk"
if [[ "$DRY_RUN" == 1 ]]; then
  info "(dry-run) skipping verification"
elif has_cmd rtk; then
  if rtk gain >/dev/null 2>&1; then
    ok "rtk: $(rtk --version 2>/dev/null || echo '(no version output)')"
    ok "'rtk gain' works — confirmed rtk-ai/rtk"
  else
    warn "rtk on PATH but 'rtk gain' still fails"
    warn "Check: which rtk → $(command -v rtk)"
    exit 1
  fi
else
  warn "rtk not on PATH — ensure ~/.local/bin or cargo bin is exported"
  exit 1
fi

mark_done "$SECTION_ID"
ok "Section complete: $SECTION_ID"
