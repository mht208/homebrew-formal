require 'formula'

class Mona < Formula
  homepage 'http://www.brics.dk/mona/'
  url 'http://www.brics.dk/mona/download/mona-1.4-15.tar.gz'
  sha256 '8fae914463a5813c46a53a4a57eeef9f873b020b155dea407c83eaf0d6d82668'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--datadir=#{share}/mona"
    system "make"
    system "make install-strip"
  end
end
