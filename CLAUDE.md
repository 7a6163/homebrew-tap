# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Homebrew tap for [7a6163](https://github.com/7a6163)'s tools. This repo
is a Homebrew tap: a collection of formula files that let users install tools via
`brew tap 7a6163/tap` and `brew install 7a6163/tap/<formula>`.

## Layout

- `Formula/` — one Ruby formula file per tool (`<name>.rb`), for tools built
  from source. Homebrew requires formulae to live in this directory.
- `Casks/` — one Ruby cask file per app (`<name>.rb`), for pre-built macOS GUI
  apps distributed as `.dmg`/`.app`.
- `README.md` — user-facing usage and the tables of available formulae/casks.

## Formulae

- `Formula/tapwarden.rb` — SSH agent for Bitwarden/Vaultwarden with a Touch ID
  prompt on every signature. macOS-only. Apple Silicon installs the prebuilt
  release binary; Intel builds from source with Rust (`cargo install`).
  Upstream: https://github.com/7a6163/tapwarden
- `Formula/gem-audit.rb` — Ultra-fast, standalone security auditor for
  `Gemfile.lock`, written in Rust. Cross-platform; installs the prebuilt
  release tarball per OS/arch.
  Upstream: https://github.com/7a6163/gem-audit
- `Formula/rubyfast.rb` — Ultra-fast Ruby performance linter rewritten in Rust
  (fasterer port) with auto-fix. Cross-platform; installs the prebuilt
  release tarball per OS/arch.
  Upstream: https://github.com/7a6163/rubyfast

## Casks

- `Casks/fanhuaji.rb` — 繁化姬 Tauri 版, Chinese text converter desktop app
  (Tauri 2, based on the zhconvert.org API). Installs the universal `.dmg` from
  GitHub releases. Bundle identifier `org.zhconvert.fanhuaji`; the app is
  unsigned. Upstream: https://github.com/7a6163/fanhuaji-tauri

## Conventions

- Formula class name is the CamelCase form of the filename (e.g. `tapwarden.rb` →
  `class Tapwarden < Formula`). Cask uses `cask "<name>" do`.
- Formulae: pin a `version`, build each `url` from `#{version}`, and pin the
  matching `sha256` per OS/arch. Most releases ship a `sha256sums.txt` asset —
  take the checksums from there.
- Casks: pin `version` and `sha256` of the release asset; build the download
  `url` from `#{version}`. Compute checksums with
  `curl -L <url> | shasum -a 256`.
- Keep the `README.md` Formulae/Casks tables and any per-item notes in sync when
  adding, removing, or bumping an entry.

## Common tasks

Bumping a formula version:

1. Update `version` and refresh every `sha256` (from the release's
   `sha256sums.txt`, or `curl -L <url> | shasum -a 256`).
2. Run `brew audit --strict --online 7a6163/tap/<name>` (auditing by path is
   disabled in current Homebrew). The audit reads the installed tap clone at
   `$(brew --repository 7a6163/tap)`, not this checkout — fast-forward it first
   with `git -C "$(brew --repository 7a6163/tap)" pull --ff-only <this repo> main`.
   `--strict` reports "`version` is redundant with version scanned from URL";
   that is expected from the pin-`version` convention above, so ignore it.
3. Run `brew install 7a6163/tap/<name>` and `brew test 7a6163/tap/<name>`.

Bumping a cask version:

1. Update `version` and `sha256` (from the new release's macOS asset).
2. Run `brew audit --strict --online --cask 7a6163/tap/<name>` (sync the tap
   clone first, as above).
3. Run `brew install --cask Casks/<name>.rb` to verify it installs.

Adding a formula or cask:

1. Create `Formula/<name>.rb` or `Casks/<name>.rb` following the existing style.
2. Add a row to the matching README table.
3. Audit and test as above.

## Notes

- No CI, build system, or test suite in this repo; validation is done through
  Homebrew's own tooling (`brew audit`, `brew install`, `brew test`).
- `tapwarden` produces an unsigned binary, so the macOS keychain may re-prompt
  once after upgrades. This is documented in the formula `caveats` and the README.
- `fanhuaji` is also unsigned; Gatekeeper may block first launch. The cask
  `caveats` and README explain the `xattr -cr` / "Open Anyway" workaround.
- `tapwarden` pins two checksums from different sources: the Apple Silicon
  release binary (published as a per-asset
  `tapwarden-v<version>-aarch64-apple-darwin.sha256`, not `sha256sums.txt`) and the Intel source
  tarball `archive/refs/tags/v<version>.tar.gz`, which is not a release asset —
  compute that one with `curl -L <url> | shasum -a 256`.
- On an Apple Silicon machine, `brew install` only exercises the `on_arm`
  branch; the Intel `cargo install` path is not tested locally.
- Commit messages follow the pattern `Bump <name> to <version> and update
  SHA-256 checksums` (casks: `Bump <name> cask to <version>`).
