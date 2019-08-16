require 'formula'

class Mona < Formula
  homepage 'http://www.brics.dk/mona/'
  url 'http://www.brics.dk/mona/download/mona-1.4-17.tar.gz'
  sha256 'cd50d6db7410fcdc1c87ff95278b69fc95624107092a69f754bb999746a68763'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--datadir=#{share}/mona"
    system "make"
    system "make install"
  end
end
