require 'formula'

class Spot < Formula
  homepage 'https://spot.lrde.epita.fr/index.html'
  url 'http://www.lrde.epita.fr/dload/spot/spot-1.99.4.tar.gz'
  sha256 '89ab540ecf8a12045f8fa6cbeb6995eaaab213d815c4baee108d3744380bff09'

  def install
    # Since Spot uses modified Buddy and Lbtt, we build statically linked Spot.
    system "./configure", "--prefix=#{prefix}", "--disable-shared", "--disable-python"
    system "make"
    bin.install "src/bin/autfilt", "src/bin/dstar2tgba", "src/bin/genltl",
                "src/bin/ltl2tgba", "src/bin/ltl2tgta", "src/bin/ltlcross",
                "src/bin/ltldo", "src/bin/ltlfilt", "src/bin/ltlgrind",
                "src/bin/randaut", "src/bin/randltl", "src/bin/spot-x"
    man1.install Dir["src/bin/man/*.1"], Dir["src/bin/man/*.x"]
    doc.install "doc/tl/tl.pdf"
    lib.install "src/.libs/libspot.a", "src/.libs/libspot.la", "src/.libs/libspot.lai"
  end
end
