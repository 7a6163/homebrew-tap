class Sigilo < Formula
  desc "SSH agent for Bitwarden/Vaultwarden with a Touch ID prompt on every signature"
  homepage "https://github.com/7a6163/sigilo"
  url "https://github.com/7a6163/sigilo/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "101907ec0a08ede293accdefdcd9f6689f5a61767629a56b46d56536a041b8ae"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
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
