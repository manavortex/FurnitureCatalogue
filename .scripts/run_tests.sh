#!/usr/bin/env bash
#
# Run test suites headless via ESOLua
#
# Usage:
#   .scripts/run_tests.sh [suite-id ...]
#
# Leave id empty to run every suite
#
# Paths from env vars or .scripts/.env (see env.example)
#   ESOLUA       path to esolua executable
#   ESOUI_SRC    ESOUI source root (libraries/globals/)
#   TANETH_DIR   dir containing Taneth.txt

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ -f "$SCRIPT_DIR/.env" ]]; then
  set -a; . "$SCRIPT_DIR/.env"; set +a
fi

fail() { echo "run_tests.sh: $1" >&2; exit 2; }

# Offer download if tool vars are not set
# Fails when tool vars set but tools not found
offer_clone() { # <name> <url> <dir>
  [[ -t 0 ]] || fail "$1 not found - set it in .scripts/.env"
  read -rp "$1 not found. Download to $3? [y/N] " answer
  [[ "$answer" == [yY]* ]] || fail "$1 not found"
  git clone --depth 1 "$2" "$3"
}

# you might have to install dependencies for esolua
if [[ -z "${ESOLUA:-}" ]]; then
  ESOLUA="$REPO_ROOT/../esolua/src/lua"
  if [[ ! -x "$ESOLUA" ]]; then
    for tool in gcc make xxd; do
      command -v "$tool" >/dev/null || fail "building esolua needs $tool — install it or set ESOLUA"
    done
    [[ -d "$REPO_ROOT/../esolua" ]] \
      || offer_clone esolua https://github.com/sirinsidiator/ESOLua.git "$REPO_ROOT/../esolua"
    make -C "$REPO_ROOT/../esolua" posix # posix is 1 dependency less
  fi
fi

# get esoui source code (we need some files from it)
if [[ -z "${ESOUI_SRC:-}" ]]; then
  ESOUI_SRC="$REPO_ROOT/../esoui/esoui"
  [[ -d "$ESOUI_SRC" ]] \
    || offer_clone "ESOUI source" https://github.com/esoui/esoui.git "$REPO_ROOT/../esoui"
fi

# get taneth test framework
if [[ -z "${TANETH_DIR:-}" ]]; then
  TANETH_DIR="$REPO_ROOT/../ESO-Taneth/src"
  [[ -f "$TANETH_DIR/Taneth.txt" ]] \
    || offer_clone Taneth https://github.com/wookiefriseur/ESO-Taneth.git "$REPO_ROOT/../ESO-Taneth"
fi

[ -x "$ESOLUA" ] || fail "esolua not found at '$ESOLUA' (set ESOLUA)"
[ -d "$ESOUI_SRC/libraries/globals" ] || fail "ESOUI source not found at '$ESOUI_SRC' (set ESOUI_SRC)"
[ -f "$TANETH_DIR/Taneth.txt" ] || fail "Taneth not found at '$TANETH_DIR' (set TANETH_DIR)"

exec "$ESOLUA" -s "$ESOUI_SRC" -- \
    "$REPO_ROOT/.scripts/taneth_headless.lua" \
    "$REPO_ROOT" "$TANETH_DIR" "$@"
