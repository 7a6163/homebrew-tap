class GemAudit < Formula
  desc "Ultra-fast, standalone security auditor for Gemfile.lock, written in Rust"
  homepage "https://github.com/7a6163/gem-audit"
  url "https://github.com/7a6163/gem-audit/archive/refs/tags/v2.10.0.tar.gz"
  sha256 "7829ade892765cdab495cc1ebe2367bf04819f66159bd6bc270dce77fa905c56"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "gem-audit", shell_output("#{bin}/gem-audit version")
  end
end
