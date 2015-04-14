require 'formula'

class Gappa < Formula
  homepage 'http://gappa.gforge.inria.fr'
  url 'https://gforge.inria.fr/frs/download.php/file/34154/gappa-1.1.2.tar.gz'
  sha1 'd70776005d96d6ba06c8a98c6dcecb32424805d6'

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "boost"

  def install
    system "./configure"
    system "./remake"
    bin.install 'src/gappa'
  end
end
