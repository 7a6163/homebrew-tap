# homebrew-tap

Personal Homebrew tap for [7a6163](https://github.com/7a6163)'s tools.

## Usage

```sh
brew tap 7a6163/tap
brew install <formula>
```

Or install directly:

```sh
brew install 7a6163/tap/sigilo
```

## Formulae

| Formula | Description |
|---------|-------------|
| [`sigilo`](https://github.com/7a6163/sigilo) | SSH agent for Bitwarden/Vaultwarden with a Touch ID prompt on every signature (macOS, builds from source with Rust) |

### sigilo

After installing, configure a backend and install the launch agent:

```sh
sigilo setup
sigilo start
```

Note: after upgrades the macOS keychain may re-prompt once for access, since the unsigned binary changed.

## License

Formulae in this tap are MIT-licensed; see each upstream project for its own license.
