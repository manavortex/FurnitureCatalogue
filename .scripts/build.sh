#!/usr/bin/env bash
#
# local-dev wrapper around release pipeline scripts. Zips go to .dist/
#
# Usage:
#  ./build.sh                          regen autocomplete + locales + stylua format
#  ./build.sh --release                bump current ESOUI version + package
#  ./build.sh --release X.Y.Z          bump to version + package
#  ./build.sh --release [...] --publish    + upload .dist/<zip> to ESOUI
#  ./build.sh --help                   this message
#
# Setup:
#   - python3 with libs from .scripts/requirements.txt
#       (pip install -r .scripts/requirements.txt)
#   - StyLua is auto-fetched (pinned to the CI version) by .scripts/stylua.sh
#   - Optional .env file in repo root, see env.example

set -euo pipefail

# ------------------------------------------
# locate repo root (one dir up from .scripts)
# ------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# ------------------------------------------
# load optional .env
# ------------------------------------------
if [[ -f "$SCRIPT_DIR/.env" ]]; then
  set -a; . "$SCRIPT_DIR/.env"; set +a
fi

# ------------------------------------------
# args
# ------------------------------------------
DO_RELEASE=0
RELEASE_VERSION=""
DO_PUBLISH=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --release)
      DO_RELEASE=1
      # Version optional. If set MUST be a valid X.Y.Z version
      if [[ -n "${2:-}" && "$2" != --* ]]; then
        if [[ "$2" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
          RELEASE_VERSION="$2"; shift 2
        else
          echo "🔥 --release got invalid version: '$2' (expected X.Y.Z or omit for auto bump)" >&2
          exit 2
        fi
      else
        shift
      fi
      ;;
    --publish) DO_PUBLISH=1; shift ;;
    -h|--help) awk 'NR>=3 {if (/^[^#]/ && !/^$/) exit; print}' "$0"; exit 0 ;;
    *) echo "unknown flag: $1 (use --help)" >&2; exit 2 ;;
  esac
done

if [[ "$DO_PUBLISH" == 1 && "$DO_RELEASE" == 0 ]]; then
  echo "🔥 --publish requires --release (we need a packaged zip to upload)" >&2
  exit 2
fi

# ------------------------------------------
# check tool paths
# ------------------------------------------
PY="${PYTHON3_BIN:-python3}"
command -v "$PY" >/dev/null || { echo "🔥 python3 not found ($PY). Set PYTHON3_BIN in .env if needed." >&2; exit 1; }

# ------------------------------------------
# 1. regen autocomplete defs + translations
# ------------------------------------------
echo "[build] regenerate autocomplete defs"
"$PY" .scripts/luaDoc_generateStr.py locale/en.lua
"$PY" .scripts/luaDoc_generateStr.py LibFurnitureCatalogue/locale/en.lua
"$PY" .scripts/luaDoc_generateGui.py xml/FurnitureCatalogue.xml docs/autocomplete_definitions.lua
"$PY" .scripts/luaDoc_generateGui.py FurnitureCatalogue_DevUtility/xml.xml docs/autocomplete_definitions.lua

echo "[build] regenerate translation files"
for langfile in locale/*.lua; do
  [[ "$langfile" == "locale/en.lua" ]] && continue
  "$PY" .scripts/luaDoc_generateStr.py locale/en.lua "$langfile" --generate-translation
done
for langfile in LibFurnitureCatalogue/locale/*.lua; do
  [[ "$langfile" == "LibFurnitureCatalogue/locale/en.lua" ]] && continue
  "$PY" .scripts/luaDoc_generateStr.py LibFurnitureCatalogue/locale/en.lua "$langfile" --generate-translation
done

# ------------------------------------------
# 2. stylua format
# ------------------------------------------
echo "[build] stylua format (pinned version via stylua.sh)"
.scripts/stylua.sh

# ------------------------------------------
# 3. release: bump + package
# ------------------------------------------
if [[ "$DO_RELEASE" == 0 ]]; then
  echo "[build] ✅ done (regen + format)."
  exit 0
fi

if [[ -z "$RELEASE_VERSION" ]]; then
  echo "[build] no version given - auto bumping minor version"
  LIVE="$("$PY" .scripts/esoui_utils.py version)"
  RELEASE_VERSION="$("$PY" .scripts/furc_utils.py nextversion --current "$LIVE")"
  echo "[build] LIVE=$LIVE → NEXT=$RELEASE_VERSION"
fi

echo "[build] bump manifest + startup.lua to $RELEASE_VERSION"
CHANGED_TMP="$(mktemp)"
"$PY" .scripts/furc_utils.py changeversion --new-version "$RELEASE_VERSION" --output-file "$CHANGED_TMP"
rm -f "$CHANGED_TMP"

echo "[build] package zip"
"$PY" .scripts/package.py
ZIP="$(ls -1 *.zip | head -1)"
test -s "$ZIP" || { echo "🔥 package.py produced no zip" >&2; exit 1; }

mkdir -p .dist
mv "$ZIP" ".dist/$ZIP"
echo "[build] ✅ release ready: .dist/$ZIP"

# ------------------------------------------
# 4. publish (optional)
# ------------------------------------------
if [[ "$DO_PUBLISH" == 1 ]]; then
  : "${ESOUI_API_TOKEN:?🔥 ESOUI_API_TOKEN not set (export it or put it in .env)}"
  echo "[build] publish .dist/$ZIP to ESOUI"
  "$PY" .scripts/publish.py \
    --changelog-max-entries 15 \
    --archive-file ".dist/$ZIP" \
    --print-response
  echo "[build] ✅ published"
fi
