class Tapwarden < Formula
  desc "SSH agent for Bitwarden/Vaultwarden with a Touch ID prompt on every signature"
  homepage "https://github.com/7a6163/tapwarden"
  version "0.3.3"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/7a6163/tapwarden/releases/download/v#{version}/tapwarden-v#{version}-aarch64-apple-darwin"
      sha256 "b2f24a1773f9117b3d8b5e0618f9c120b65ebd265de5cec12685dbb1e5bff5a8"
    end
    on_intel do
      url "https://github.com/7a6163/tapwarden/archive/refs/tags/v#{version}.tar.gz"
      sha256 "c90936b2c6f4b0296fb61d5334c45283674264be3c7a38a73e5e335bc90039c2"
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
