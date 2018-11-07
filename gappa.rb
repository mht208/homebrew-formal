require 'formula'

class Gappa < Formula
  homepage 'http://gappa.gforge.inria.fr'
  url 'https://gforge.inria.fr/frs/download.php/file/37624/gappa-1.3.3.tar.gz'
  sha256 '597f58d38ffb0c025352763a387425242723045f398ab2ad65d6f5f61b13681a'

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "boost"

  def install
    system "./configure"
    system "./remake"
    bin.install 'src/gappa'
  end
end
