class Rubyfast < Formula
  desc "Ultra-fast Ruby performance linter rewritten in Rust, with auto-fix support"
  homepage "https://github.com/7a6163/rubyfast"
  version "1.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-aarch64-apple-darwin.tar.gz"
      sha256 "503eef09e0d7596d1ea1a64c76ec2a80ae4e00ef00f4f5f6975bdbfa2971b367"
    end
    on_intel do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-x86_64-apple-darwin.tar.gz"
      sha256 "1999425d46adff0df53cb1723e968ad91f607705255e335f9356c604e26c7d81"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3080cbc9a40161fb8315fe882f864c1e07907749cc38316219180c7de7e01565"
    end
    on_intel do
      url "https://github.com/7a6163/rubyfast/releases/download/v#{version}/rubyfast-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a8d1da9eb09921d4d7c9fe76768b8de1fe704e2fd40ee78e68bb2f9771d085c4"
    end
  end

  def install
    bin.install "rubyfast"
  end

  test do
    assert_match "rubyfast", shell_output("#{bin}/rubyfast --version")
  end
end
