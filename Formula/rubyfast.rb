class Rubyfast < Formula
  desc "Ultra-fast Ruby performance linter rewritten in Rust, with auto-fix support"
  homepage "https://github.com/7a6163/rubyfast"
  version "2.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-aarch64-apple-darwin.tar.gz"
      sha256 "a371101c0549312d70b5cdd24d6cc8b21d0e3b8ae379a79df2604378e4f69539"
    end
    on_intel do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-x86_64-apple-darwin.tar.gz"
      sha256 "4559b67663deb2312ee92d6962e092f1e78aae1c24242ee1149ae6c91f51f3d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "622ae3f1f8276979ae916b553424d5f1bc63d2b6e2b24454dbc1528342dda2d8"
    end
    on_intel do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "840e540c4fdcd83be9f5d0c553fff803f48bd3639d3dcbdd709a8b67c8f1b858"
    end
  end

  def install
    bin.install "rubyfast"
  end

  test do
    assert_match "rubyfast", shell_output("#{bin}/rubyfast --version")
  end
end
