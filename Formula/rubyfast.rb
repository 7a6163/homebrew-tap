class Rubyfast < Formula
  desc "Ultra-fast Ruby performance linter rewritten in Rust, with auto-fix support"
  homepage "https://github.com/7a6163/rubyfast"
  version "1.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-aarch64-apple-darwin.tar.gz"
      sha256 "48c7ee7b9103722768140a9dcb48717554fc5934df04511be08fadcc4827c440"
    end
    on_intel do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-x86_64-apple-darwin.tar.gz"
      sha256 "0a783a874dda84eb67e68095948ded258a9d17107e46d08d569888f60510d4bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f4f8cdc84c28cf0ddc37e96f36e9249dc23bfce6fb0402928a77a29a1b8c034d"
    end
    on_intel do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f9b5913d851c1f543368b7fada1c1f6eb0228ad310456caeedede64ec47c13ed"
    end
  end

  def install
    bin.install "rubyfast"
  end

  test do
    assert_match "rubyfast", shell_output("#{bin}/rubyfast --version")
  end
end
