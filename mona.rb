require 'formula'

class Mona < Formula
  homepage 'http://www.brics.dk/mona/'
  url 'http://www.brics.dk/mona/download/mona-1.4-15.tar.gz'
  sha1 '7261d429299968372051cdd7c98bcf9be3c360dc'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--datadir=#{share}/mona"
    system "make"
    system "make install-strip"
  end
end
