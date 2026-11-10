#!/usr/bin/env bash
# Run the synthetic terminal patch fixture under Bazel.
# Called by //:terminal_da_reply_test; never builds or launches the app.
set -uo pipefail

runfiles="${TEST_SRCDIR:?}/${TEST_WORKSPACE:?}"
stage="$(mktemp -d "${TEST_TMPDIR:?}/terminal-da.XXXXXX")" || exit 1
trap 'rm -rf -- "$stage"' EXIT
mkdir -p "$stage/scripts/patches" "$stage/tests" "$stage/home" || exit 1
files=(
	scripts/patches/app-asar.sh
	scripts/patches/terminal-da-reply.sh
	tests/terminal-da-reply.bats
)
for file in "${files[@]}"; do
	cp "$runfiles/$file" "$stage/$file" || exit 1
done
export HOME="$stage/home"
export TMPDIR="$TEST_TMPDIR"
cd "$stage" || exit 1
bats tests/terminal-da-reply.bats
