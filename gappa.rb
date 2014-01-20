require 'formula'

class Gappa < Formula
  homepage 'http://gappa.gforge.inria.fr'
  url 'https://gforge.inria.fr/frs/download.php/33305/gappa-1.1.0.tar.gz'
  sha1 '4752c3243b98edadaa959390e07167c136c79aa9'

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "boost"

  def install
    system "./configure"
    system "./remake"
    bin.install 'src/gappa'
  end
end
