class Cpphoafparser < Formula
  desc "Command-line tool for performing basic operations on HOA automata"
  homepage "https://automata.tools/hoa/cpphoafparser/"
  url "https://automata.tools/hoa/cpphoafparser/down/cpphoafparser-0.99.2.tgz"
  sha256 "3c017becc6f64d79e6139a6e0d60ac5ccf0853ec8c6fc378c830c2ba2d9e7e94"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://github.com/lou1306/homebrew-formal/releases/download/cpphoafparser-0.99.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "efc97a8e4624760046fc8e96a823cf0211856ada1c0616976f0f08687141c06e"
  end

  def install
    system "make"
    bin.install "cpphoaf"
    (include/"cpphoafparser").install Dir["include/cpphoafparser/*"]
  end
end
