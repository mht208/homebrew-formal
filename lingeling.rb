require 'formula'

class Lingeling < Formula
  homepage 'http://fmv.jku.at/lingeling/'
  url 'http://fmv.jku.at/lingeling/lingeling-al6-080d45d-120922.tar.gz'
  sha1 '1cc73193396309c6e7b020c59d9c51d9f0a7264d'

  depends_on 'aiger'

  def install
    system "./configure --aiger=/usr/local/share/aiger"
    system "make"
    bin.install "blimc", "ilingeling", "lingeling", "plingeling"
    lib.install "liblgl.a"
    include.install "lglib.h"
  end

end
