require 'formula'

class Gappa < Formula
  homepage 'http://gappa.gforge.inria.fr'
  url 'https://gforge.inria.fr/frs/download.php/31075/gappa-0.16.1.tar.gz'
  sha1 'ba268f24552dfc3fdca06948765c834ba93c8a27'

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "boost"

  def install
    ENV['CXX'] = "g++"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
