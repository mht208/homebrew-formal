require 'formula'

class Lingeling < Formula
  desc 'a SAT solver'
  homepage 'http://fmv.jku.at/lingeling/'
  url 'http://fmv.jku.at/lingeling/lingeling-bcj-78ebb86-180517.tar.gz'
  sha256 '2480197e48907eaaf935e96f9837366942054f26ed4c58f92ec66efedada07f2'

  def install
    system "./configure.sh"
    system "make"
    bin.install "ilingeling", "lglddtrace", "lglmbt", "lgluntrace",
                "lingeling", "plingeling", "treengeling"
    lib.install "liblgl.a"
    (include/'lingeling').install Dir['*.h']
  end

end
