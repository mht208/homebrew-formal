require 'formula'

class Gappa < Formula
  homepage 'http://gappa.gforge.inria.fr'
  url 'https://gappa.gitlabpages.inria.fr/releases/gappa-1.4.1.tar.gz'
  sha256 'bc581761c299519eb02574add17fcb820900034566783b1dab9c29939203397a'

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "boost"

  def install
    system "./configure"
    system "./remake"
    bin.install 'src/gappa'
  end
end
