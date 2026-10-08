class Tapwarden < Formula
  desc "SSH agent for Bitwarden/Vaultwarden with a Touch ID prompt on every signature"
  homepage "https://github.com/7a6163/tapwarden"
  version "0.3.1"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/7a6163/tapwarden/releases/download/v#{version}/tapwarden-v#{version}-aarch64-apple-darwin"
      sha256 "cfc2c76a80aa52956546f292dbbb30ce783a8517737928a1be235e63700c6a89"
    end
    on_intel do
      url "https://github.com/7a6163/tapwarden/archive/refs/tags/v#{version}.tar.gz"
      sha256 "d5077f587c9231285dca74fe9d163affde4c6fd6fea6b04de44b83d715c6fcf4"
      depends_on "rust" => :build
    end
  end

  def install
    if Hardware::CPU.arm?
      binary = "tapwarden-v#{version}-aarch64-apple-darwin"
      chmod 0755, binary
      bin.install binary => "tapwarden"
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  def caveats
    <<~EOS
      Configure a backend, then install the launch agent:
        tapwarden setup
        tapwarden start

      After upgrades the macOS keychain may re-prompt once for access
      (the unsigned binary changed).

      Upgrading from 0.2.x: the agent socket moved out of $TMPDIR. Re-run
      `tapwarden start` and update IdentityAgent in ~/.ssh/config to the
      path it prints.
    EOS
  end

  test do
    assert_match "tapwarden", shell_output("#{bin}/tapwarden --help")
  end
end
