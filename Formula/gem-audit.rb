class GemAudit < Formula
  desc "Ultra-fast, standalone security auditor for Gemfile.lock, written in Rust"
  homepage "https://github.com/7a6163/gem-audit"
  version "2.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/7a6163/gem-audit/releases/download/v#{version}/gem-audit-aarch64-apple-darwin.tar.gz"
      sha256 "9800754db66160ae4a997d963f761f2f59127ecdf324dd923c45c27a74c096d3"
    end
    on_intel do
      url "https://github.com/7a6163/gem-audit/releases/download/v#{version}/gem-audit-x86_64-apple-darwin.tar.gz"
      sha256 "4842837a124fabcbdef2d7c6f62e03e509757221caea5187add33920473de599"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/7a6163/gem-audit/releases/download/v#{version}/gem-audit-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9cca707114e6215d5a45e626be616fe986221d4e8f29a7c954065f94b83726ca"
    end
    on_intel do
      url "https://github.com/7a6163/gem-audit/releases/download/v#{version}/gem-audit-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "727e552d081aea5bbc0a3246b4152d887b4ecc5558fff3c2a548137ac59e569e"
    end
  end

  def install
    bin.install "gem-audit"
  end

  test do
    assert_match "gem-audit", shell_output("#{bin}/gem-audit version")
  end
end
