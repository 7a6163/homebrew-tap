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
brew install --cask 7a6163/tap/fanhuaji
```

## Formulae

| Formula | Description |
|---------|-------------|
| [`sigilo`](https://github.com/7a6163/sigilo) | SSH agent for Bitwarden/Vaultwarden with a Touch ID prompt on every signature (macOS, builds from source with Rust) |

## Casks

| Cask | Description |
|------|-------------|
| [`fanhuaji`](https://github.com/7a6163/fanhuaji-tauri) | 繁化姬 Tauri 版, Chinese text converter desktop app based on the zhconvert.org API (macOS, universal `.dmg`) |

### fanhuaji

The app is not signed by Apple. On first launch macOS may block it; open
**System Settings > Privacy & Security** and click **Open Anyway**, or run:

```sh
xattr -cr "/Applications/Fanhuaji.app"
```

### sigilo

After installing, configure a backend and install the launch agent:

```sh
sigilo setup
sigilo start
```

Note: after upgrades the macOS keychain may re-prompt once for access, since the unsigned binary changed.

## License

Formulae in this tap are MIT-licensed; see each upstream project for its own license.
