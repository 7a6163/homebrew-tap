class Tapwarden < Formula
  desc "SSH agent for Bitwarden/Vaultwarden with a Touch ID prompt on every signature"
  homepage "https://github.com/7a6163/tapwarden"
  version "0.2.4"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/7a6163/tapwarden/releases/download/v#{version}/tapwarden-v#{version}-aarch64-apple-darwin"
      sha256 "9899b720a9566781f2e4cf9ea6b885fe866ae176062801cd0ad339340b73d9e5"
    end
    on_intel do
      url "https://github.com/7a6163/tapwarden/archive/refs/tags/v#{version}.tar.gz"
      sha256 "18002c7e088040b3c04e755a84678782a488c0c40879ef6f2b5175877267289c"
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
