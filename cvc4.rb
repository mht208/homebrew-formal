require 'formula'

class Cvc4 < Formula
  homepage 'http://cvc4.cs.nyu.edu'
  url 'http://cvc4.cs.stanford.edu/downloads/builds/src/cvc4-1.6.tar.gz'
  version '1.6'
  sha256 '5c18bd5ea893fba9723a4d35c889d412ec6d29a21db9db69481891a8ff4887c7'

  depends_on 'gmp'
  depends_on 'python'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
