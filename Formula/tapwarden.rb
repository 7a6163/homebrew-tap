class Tapwarden < Formula
  desc "SSH agent for Bitwarden/Vaultwarden with a Touch ID prompt on every signature"
  homepage "https://github.com/7a6163/tapwarden"
  version "0.2.2"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/7a6163/tapwarden/releases/download/v#{version}/tapwarden-v#{version}-aarch64-apple-darwin"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
    on_intel do
      url "https://github.com/7a6163/tapwarden/archive/refs/tags/v#{version}.tar.gz"
      sha256 "132d8c7d3fe48ac64b71459b5a83630004895f3bd0c8015744662524bef6408b"
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
    EOS
  end

  test do
    assert_match "tapwarden", shell_output("#{bin}/tapwarden --help")
  end
end
