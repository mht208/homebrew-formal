require 'formula'

class Mona < Formula
  homepage 'http://www.brics.dk/mona/'
  url 'http://www.brics.dk/mona/download/mona-1.4-18.tar.gz'
  sha256 'ece10e1e257dcae48dd898ed3da48f550c6b590f8e5c5a6447d0f384ac040e4c'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--datadir=#{share}/mona"
    system "make"
    system "make install"
  end
end
