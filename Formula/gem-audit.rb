class GemAudit < Formula
  desc "Ultra-fast, standalone security auditor for Gemfile.lock, written in Rust"
  homepage "https://github.com/7a6163/gem-audit"
  version "2.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/7a6163/gem-audit/releases/download/v#{version}/gem-audit-aarch64-apple-darwin.tar.gz"
      sha256 "08f907ced58c36854cd59502e22c651995db513c5fd3d81bcee3dee4b6b68584"
    end
    on_intel do
      url "https://github.com/7a6163/gem-audit/releases/download/v#{version}/gem-audit-x86_64-apple-darwin.tar.gz"
      sha256 "09f83223c00bd06002fe3244c261dad7715efd2bce1a56c66bb0698394fdfc4d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/7a6163/gem-audit/releases/download/v#{version}/gem-audit-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5aa2d534e33afca0b45da3cbcb92a478c6055c30f3fd56d537e7d522a012cc6e"
    end
    on_intel do
      url "https://github.com/7a6163/gem-audit/releases/download/v#{version}/gem-audit-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b80e1a6d88fc0f1521842ecc464b814cc2a7f00fcb0c8fd202fad9a20521960"
    end
  end

  def install
    bin.install "gem-audit"
  end

  test do
    assert_match "gem-audit", shell_output("#{bin}/gem-audit version")
  end
end
