require 'formula'

class Mathsat < Formula
  homepage 'http://mathsat.fbk.eu/index.html'
  url 'http://mathsat.fbk.eu/download.php?file=mathsat-5.1.12-darwin-x86_64.tar.gz'
  version '5.1.12'
  sha1 '3f34baef5c4cdde912b69ddf2f55f24975cf8062'

  def install
    bin.install 'bin/mathsat'
    include.install 'include/mathsat.h'
    lib.install 'lib/libmathsat.a'
    (share/'mathsat').install 'configurations', 'examples'
  end
end
