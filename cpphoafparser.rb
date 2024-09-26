class Cpphoafparser < Formula
  desc "Command-line tool for performing basic operations on HOA automata"
  homepage "https://automata.tools/hoa/cpphoafparser/"
  url "https://automata.tools/hoa/cpphoafparser/down/cpphoafparser-0.99.2.tgz"
  sha256 "3c017becc6f64d79e6139a6e0d60ac5ccf0853ec8c6fc378c830c2ba2d9e7e94"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://github.com/lou1306/homebrew-formal/releases/download/cpphoafparser-0.99.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4fbc23f4963c898121e7f95b0dde64d8338d28f9a0716e086b3b3e259ff0814a"
  end

  def install
    system "make"
    bin.install "cpphoaf"
    (include/"cpphoafparser").install Dir["include/cpphoafparser/*"]
  end
end
