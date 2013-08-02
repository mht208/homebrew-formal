require 'formula'

class Gappa < Formula
  homepage 'http://gappa.gforge.inria.fr'
  url 'https://gforge.inria.fr/frs/download.php/32744/gappa-1.0.0.tar.gz'
  sha1 'e2d5fd30f4523b124c3ed2cf5219d54d99f27b29'

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "boost"

  def install
    ENV['CXX'] = "g++"
    system "./configure"
    system "./remake"
    bin.install 'src/gappa'
  end
end
