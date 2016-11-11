require 'formula'

class Spass < Formula
  homepage 'http://www.spass-prover.org'
  url 'http://www.spass-prover.org/download/sources/spass37.tgz'
  version '3.7'
  sha256 '13c67e5e09b814ba50f38a391fe653661ba714e7541ffd4951efef91274aaacc'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
