#!/usr/bin/env bash
# Points a formula in this tap at a published release.
#
# Usage: scripts/bump-formula.sh FORMULA [VERSION]
#
# FORMULA is one of the tap's formulae. VERSION (X.Y.Z, with or without a
# leading v) defaults to the latest release on the formula's registry.
#
# - cli-bot, joedocs, passalong: sets `url` to the crates.io download of that
#   version and `sha256` to the checksum crates.io records for it, and changes
#   nothing else.
# - gmail-tool: runs scripts/update-homebrew-formula.sh from joelee/gmail-tool's
#   default branch with uv.lock from its tag vVERSION. That script rewrites
#   the formula, Python resources included, from the release's PyPI sdist and
#   lock file. Needs git, uv, and `python` 3.11 or later on PATH.
#
# A release can take a few minutes to appear on its registry after the
# upstream workflow publishes it, so the script retries for up to
# BUMP_WAIT_SECONDS (default 600) before giving up.
#
# Does nothing when the formula is already at VERSION, and refuses to move a
# formula to an older version. When GITHUB_OUTPUT is set, writes
# `changed=true|false` and `version=X.Y.Z` to it for the workflow.
set -euo pipefail

TAP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
USER_AGENT="homebrew-oss bump-formula.sh (https://github.com/joelee/homebrew-oss)"
WAIT_SECONDS="${BUMP_WAIT_SECONDS:-600}"
RETRY_INTERVAL=30
WORK_DIR=""
trap '[ -z "$WORK_DIR" ] || rm -rf "$WORK_DIR"' EXIT

fail() {
  echo "error: $*" >&2
  exit 1
}

usage() {
  echo "usage: scripts/bump-formula.sh FORMULA [VERSION]" >&2
  exit 2
}

output() {
  if [ -n "${GITHUB_OUTPUT:-}" ]; then
    printf '%s=%s\n' "$1" "$2" >> "$GITHUB_OUTPUT"
  fi
}

# Runs "$@" until it succeeds or WAIT_SECONDS have passed.
with_retries() {
  local deadline=$((SECONDS + WAIT_SECONDS))
  local status
  while true; do
    status=0
    "$@" || status=$?
    [ "$status" -eq 0 ] && return 0
    # 2 means a permanent failure, such as a yanked release.
    if [ "$status" -eq 2 ] || [ "$SECONDS" -ge "$deadline" ]; then
      return "$status"
    fi
    echo "not available yet, retrying in ${RETRY_INTERVAL}s" >&2
    sleep "$RETRY_INTERVAL"
  done
}

fetch_json() {
  curl -fsSL --retry 3 -A "$USER_AGENT" "$1"
}

# --- crates.io ---------------------------------------------------------------

crate_latest() {
  fetch_json "https://crates.io/api/v1/crates/$1" | jq -er '.crate.max_stable_version'
}

# Prints the checksum of crate $1 version $2, failing while it is not
# published yet or when it is yanked.
crate_checksum() {
  local meta
  meta="$(fetch_json "https://crates.io/api/v1/crates/$1/$2")" || return 1
  if [ "$(printf '%s' "$meta" | jq -r '.version.yanked')" = "true" ]; then
    echo "error: $1 $2 is yanked on crates.io" >&2
    return 2
  fi
  printf '%s' "$meta" | jq -er '.version.checksum'
}

bump_crate() {
  local name="$1" version="$2" file="$3" sha256 url updated
  sha256="$(with_retries crate_checksum "$name" "$version")" \
    || fail "$name $version is not on crates.io after ${WAIT_SECONDS}s"
  printf '%s\n' "$sha256" | grep -Eq '^[0-9a-f]{64}$' || fail "bad checksum '$sha256' for $name $version"
  url="https://static.crates.io/crates/$name/$name-$version.crate"
  updated="$(sed -E \
    -e "s|^  url \".*\"$|  url \"$url\"|" \
    -e "s|^  sha256 \".*\"$|  sha256 \"$sha256\"|" \
    "$file")"
  printf '%s\n' "$updated" > "$file"
}

# --- PyPI --------------------------------------------------------------------

pypi_latest() {
  fetch_json "https://pypi.org/pypi/$1/json" | jq -er '.info.version'
}

pypi_has_sdist() {
  fetch_json "https://pypi.org/pypi/$1/$2/json" \
    | jq -e '[.urls[] | select(.packagetype == "sdist")] | length == 1' > /dev/null
}

# The generator script comes from gmail-tool's default branch, so fixes to
# it apply to every bump, and the dependency lock from the release tag.
bump_gmail_tool() {
  local version="$1" file="$2" src
  with_retries pypi_has_sdist gmail-tool "$version" \
    || fail "gmail-tool $version has no sdist on PyPI after ${WAIT_SECONDS}s"
  WORK_DIR="$(mktemp -d)"
  src="$WORK_DIR/gmail-tool"
  git clone --quiet --depth 1 https://github.com/joelee/gmail-tool "$src" \
    || fail "cannot clone joelee/gmail-tool"
  git -C "$src" fetch --quiet --depth 1 origin "refs/tags/v$version:refs/tags/v$version" \
    || fail "joelee/gmail-tool has no tag v$version"
  git -C "$src" checkout --quiet "v$version" -- uv.lock
  "$src/scripts/update-homebrew-formula.sh" "v$version" "$file"
}

# --- main --------------------------------------------------------------------

[ $# -ge 1 ] && [ $# -le 2 ] || usage
formula="$1"
version="${2:-}"
version="${version#v}"
file="$TAP_DIR/Formula/$formula.rb"

case "$formula" in
  cli-bot | joedocs | passalong) registry=crates ;;
  gmail-tool) registry=pypi ;;
  *) fail "unknown formula '$formula'" ;;
esac
[ -f "$file" ] || fail "$file does not exist"
if [ "$(grep -cE '^  url "' "$file")" -ne 1 ] || [ "$(grep -cE '^  sha256 "' "$file")" -ne 1 ]; then
  fail "$file needs exactly one top-level url line and one sha256 line"
fi

current="$(grep -E '^  url "' "$file" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | tail -n 1)"
[ -n "$current" ] || fail "cannot read the current version from $file"

if [ -z "$version" ]; then
  if [ "$registry" = crates ]; then
    version="$(crate_latest "$formula")" || fail "cannot read the latest $formula version from crates.io"
  else
    version="$(pypi_latest "$formula")" || fail "cannot read the latest $formula version from PyPI"
  fi
fi
printf '%s\n' "$version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$' \
  || fail "version '$version' is not of the form MAJOR.MINOR.PATCH"

output version "$version"
if [ "$version" = "$current" ]; then
  echo "$formula is already at $version"
  output changed false
  exit 0
fi
if [ "$(printf '%s\n%s\n' "$current" "$version" | sort -V | tail -n 1)" != "$version" ]; then
  fail "$formula is at $current, newer than the requested $version"
fi

echo "bumping $formula from $current to $version"
if [ "$registry" = crates ]; then
  bump_crate "$formula" "$version" "$file"
else
  bump_gmail_tool "$version" "$file"
fi

if git -C "$TAP_DIR" diff --quiet -- "Formula/$formula.rb"; then
  fail "Formula/$formula.rb did not change"
fi
echo "Formula/$formula.rb now installs $formula $version"
output changed true
