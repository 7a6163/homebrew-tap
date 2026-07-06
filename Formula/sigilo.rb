class Sigilo < Formula
  desc "SSH agent for Bitwarden/Vaultwarden with a Touch ID prompt on every signature"
  homepage "https://github.com/7a6163/sigilo"
  version "0.1.3"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/7a6163/sigilo/releases/download/v#{version}/sigilo-v#{version}-aarch64-apple-darwin"
      sha256 "c1005d8178882d0c38f7309ab9c7b3544d6456ec9896bb80880591b43543610c"
    end
    on_intel do
      url "https://github.com/7a6163/sigilo/archive/refs/tags/v#{version}.tar.gz"
      sha256 "16904dcd3b4d34865cacd4da0502ecc2bb397594ddde55b8dc534bed52076505"
      depends_on "rust" => :build
    end
  end

  def install
    if Hardware::CPU.arm?
      binary = "sigilo-v#{version}-aarch64-apple-darwin"
      chmod 0755, binary
      bin.install binary => "sigilo"
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  def caveats
    <<~EOS
      Configure a backend, then install the launch agent:
        sigilo setup
        sigilo start

      After upgrades the macOS keychain may re-prompt once for access
      (the unsigned binary changed).
    EOS
  end

  test do
    assert_match "sigilo", shell_output("#{bin}/sigilo --help")
  end
end
