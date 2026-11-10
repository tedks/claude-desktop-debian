#!/usr/bin/env bash
set -uo pipefail

runfiles="$TEST_SRCDIR/$TEST_WORKSPACE"
stage="$(mktemp -d "${TEST_TMPDIR:?}/terminal-da.XXXXXX")" || exit 1
trap 'rm -rf -- "$stage"' EXIT
mkdir -p "$stage/scripts/patches" "$stage/tests" "$stage/home" || exit 1
for file in scripts/patches/app-asar.sh scripts/patches/terminal-da-reply.sh tests/terminal-da-reply.bats; do
  cp "$runfiles/$file" "$stage/$file" || exit 1
done
export HOME="$stage/home"
export TMPDIR="$TEST_TMPDIR"
cd "$stage" || exit 1
bats tests/terminal-da-reply.bats
