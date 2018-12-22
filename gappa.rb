require 'formula'

class Gappa < Formula
  homepage 'http://gappa.gforge.inria.fr'
  url 'https://gforge.inria.fr/frs/download.php/file/37624/gappa-1.3.3.tar.gz'
  sha256 '1c88d2ae96cd88a49af37393d06e92ffa20abdc8b170830fcdcde03ae8208e44'

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "boost"

  def install
    system "./configure"
    system "./remake"
    bin.install 'src/gappa'
  end
end
