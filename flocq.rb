require 'formula'

class Flocq < Formula
  homepage 'http://flocq.gforge.inria.fr'
  url 'http://gforge.inria.fr/frs/download.php/file/33979/flocq-2.4.0.tar.gz'
  sha256 '9b7ed4dc6b14430f48cd9cc13980815228a49bda69f15fee9ecdee3ca7251d08'

  depends_on 'coq'

  def install
    system "./configure", "--prefix=#{prefix}", "--libdir=#{prefix}/lib/coq/user-contrib/Flocq"
    system "./remake"
    system "./remake install"
  end
end
