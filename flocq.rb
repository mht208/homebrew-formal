require 'formula'

class Flocq < Formula
  homepage 'http://flocq.gforge.inria.fr'
  url 'http://gforge.inria.fr/frs/download.php/file/33979/flocq-2.4.0.tar.gz'
  sha1 '814eda9e177501fe9b2a78d290dc1c45d81af415'

  depends_on 'coq'

  def install
    system "./configure", "--prefix=#{prefix}", "--libdir=#{prefix}/lib/coq/user-contrib/Flocq"
    system "./remake"
    system "./remake install"
  end
end
