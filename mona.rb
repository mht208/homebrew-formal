require 'formula'

class Mona < Formula
  homepage 'http://www.brics.dk/mona/'
  url 'http://www.brics.dk/mona/download/mona-1.4-13.tar.gz'
  sha1 '1ca3472280d70cc1be82a864d7cff310c3a7a936'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--datadir=#{share}/mona"
    system "make"
    system "make install-strip"
  end
end
