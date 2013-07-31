require 'formula'

class Mathsat < Formula
  homepage 'http://mathsat.fbk.eu/index.html'
  url 'http://mathsat.fbk.eu/download.php?file=mathsat-5.2.8-darwin-libcxx-x86_64.tar.gz'
  version '5.2.8'
  sha1 'b89776c4648c0d4f8a503c4757e15dfa0964f6f6'

  def install
    bin.install 'bin/mathsat'
    include.install 'include/mathsat.h'
    lib.install 'lib/libmathsat.a'
    (share/'mathsat').install 'configurations', 'examples'
  end
end
