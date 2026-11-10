# Portable terminal patch test

The Bazel target exercises the existing DA1 terminal patch against synthetic JavaScript fixtures.

```bash
nix develop --command bazel test //:terminal_da_reply_test --nocache_test_results
```

The Nix shell pins Bazel 7.6.0, Bats, and Node 22. The target inherits that shell's `PATH`; running it outside the pinned shell may select different tools and is not the documented gate. Bazel lists the Bats fixture test and its two sourced patch scripts as runfiles. The wrapper copies them into a per-test scratch directory, so patch output cannot edit the checkout. The Linux sandbox blocks network access; this test does not download the official desktop package, build a release artifact, install or launch the desktop app, or start the live harness. Existing build and release entrypoints remain separate operator actions.
