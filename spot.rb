require 'formula'

class Spot < Formula
  homepage 'http://spot.lip6.fr/'
  url 'http://spot.lip6.fr/dl/spot-1.0.tar.gz'
  sha1 '83723a07a4afa21382c48a714cbc35e64b42d0dd'

  def install
    # Since Spot uses modified Buddy and Lbtt, we build statically linked Spot.
    system "./configure", "--prefix=#{prefix}", "--disable-shared"
    system "make"
    bin.install "src/bin/genltl", "src/bin/ltl2tgba", "src/bin/ltl2tgta", "src/bin/ltlcross", "src/bin/ltlfilt", "src/bin/randltl"
    man1.install "src/bin/man/genltl.1", "src/bin/man/ltl2tgba.1", "src/bin/man/ltl2tgta.1", "src/bin/man/ltlcross.1", "src/bin/man/ltlfilt.1", "src/bin/man/randltl.1"
    doc.install "doc/tl/tl.pdf"
    lib.install "src/.libs/libspot.a", "src/.libs/libspot.la", "src/.libs/libspot.lai"
  end
end
