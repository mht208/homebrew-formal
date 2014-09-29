require 'formula'

class Gappa < Formula
  homepage 'http://gappa.gforge.inria.fr'
  url 'https://gforge.inria.fr/frs/download.php/33486/gappa-1.1.1.tar.gz'
  sha1 'e50552a0578e0b4e73241c59c457fd4c416870ef'

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "boost"

  def install
    system "./configure"
    system "./remake"
    bin.install 'src/gappa'
  end
end
