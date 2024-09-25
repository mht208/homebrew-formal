class Cpphoafparser < Formula
  desc "Command-line tool for performing basic operations on HOA automata"
  homepage "https://automata.tools/hoa/cpphoafparser/"
  url "https://automata.tools/hoa/cpphoafparser/down/cpphoafparser-0.99.2.tgz"
  sha256 "3c017becc6f64d79e6139a6e0d60ac5ccf0853ec8c6fc378c830c2ba2d9e7e94"
  license "LGPL-2.1-or-later"

  def install
    system "make"
    bin.install "cpphoaf"
    (include/"cpphoafparser").install Dir["include/cpphoafparser/*"]
  end
end
