require 'formula'

class Spot < Formula
  homepage 'https://spot.lrde.epita.fr/index.html'
  url 'http://www.lrde.epita.fr/dload/spot/spot-2.7.tar.gz'
  sha256 '3ea000ac443c780f09574ec059c8931436783227c6afb43b24c863e85a22b5ef'

  depends_on 'python3'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
