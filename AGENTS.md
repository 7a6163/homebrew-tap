# AGENTS.md

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
2. Run `brew audit --strict --online Formula/<name>.rb`.
3. Run `brew install 7a6163/tap/<name>` and `brew test 7a6163/tap/<name>`.

Bumping a cask version:

1. Update `version` and `sha256` (from the new release's macOS asset).
2. Run `brew audit --strict --online Casks/<name>.rb`.
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
