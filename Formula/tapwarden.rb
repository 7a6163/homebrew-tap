class Tapwarden < Formula
  desc "SSH agent for Bitwarden/Vaultwarden with a Touch ID prompt on every signature"
  homepage "https://github.com/7a6163/tapwarden"
  version "0.2.3"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/7a6163/tapwarden/releases/download/v#{version}/tapwarden-v#{version}-aarch64-apple-darwin"
      sha256 "0498e6d8d4d28f52856095618761d978185de96c3372c18a80df6cecf5d6bf73"
    end
    on_intel do
      url "https://github.com/7a6163/tapwarden/archive/refs/tags/v#{version}.tar.gz"
      sha256 "d8c3e21c5fd93917e762ec30264409fdcdb108ff5fd4a087dd76c723448b0daf"
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
