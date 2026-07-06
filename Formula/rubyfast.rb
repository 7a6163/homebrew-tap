class Rubyfast < Formula
  desc "Ultra-fast Ruby performance linter rewritten in Rust, with auto-fix support"
  homepage "https://github.com/7a6163/rubyfast"
  url "https://github.com/7a6163/rubyfast/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "233253fef09a76ba7279af803252d2bd638af1e923d3f6b75f2ce187153fd44d"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "rubyfast", shell_output("#{bin}/rubyfast --version")
  end
end
