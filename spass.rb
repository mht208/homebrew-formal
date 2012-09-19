require 'formula'

class Spass < Formula
  homepage 'http://www.spass-prover.org'
  url 'http://www.spass-prover.org/download/sources/spass37.tgz'
  version '3.7'
  sha1 '68b1e570381b1bedafb5c682f4dee7ed3a6c6874'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
