#!/usr/bin/env bash
# Format the repo with the EXACT StyLua version from actions
#
# Reads version from .github/actions/setup-stylua/action.yml
#
# Usage:
#   .scripts/stylua.sh                 # format the whole repo
#   .scripts/stylua.sh --check         # check the whole repo (non-zero if unformatted)
#   .scripts/stylua.sh path [path...]  # format specific files/dirs
#   .scripts/stylua.sh --check path    # check specific files
#
# Env:
#   STYLUA_CACHE   location for cached binary (default: ~/.cache/bins)
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
action="$repo_root/.github/actions/setup-stylua/action.yml"

version="$(grep -oE 'STYLUA_VERSION:[[:space:]]*"?[0-9]+\.[0-9]+\.[0-9]+' "$action" 2>/dev/null \
  | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)"
if [ -z "$version" ]; then
  echo "stylua.sh: could not read STYLUA_VERSION from $action" >&2
  exit 1
fi

cache_dir="${STYLUA_CACHE:-$HOME/.cache/bins}"
bin="$cache_dir/stylua-$version"

# Fetch pinned binary if cached one is missing or has wrong version
if ! "$bin" --version 2>/dev/null | grep -qF "$version"; then
  echo "stylua.sh: fetching StyLua v$version ..." >&2
  tmp="$(mktemp -d)"
  url="https://github.com/JohnnyMorganz/StyLua/releases/download/v${version}/stylua-linux-x86_64.zip"
  if ! curl -fsSL -o "$tmp/stylua.zip" "$url"; then
    rm -rf "$tmp"
    echo "stylua.sh: download failed (offline?). No formatting done." >&2
    exit 1
  fi
  unzip -oq "$tmp/stylua.zip" -d "$tmp"
  mkdir -p "$cache_dir"
  install -m 0755 "$tmp/stylua" "$bin"
  rm -rf "$tmp"
fi

# Default to whole repo if no path given
has_path=0
for a in "$@"; do case "$a" in -*) ;; *) has_path=1 ;; esac; done
[ "$has_path" -eq 0 ] && set -- "$@" .

exec "$bin" --config-path "$repo_root/stylua.toml" "$@"
