require 'formula'

class Ltl3ba < Formula
  homepage 'http://sourceforge.net/projects/ltl3ba/'
  url 'http://sourceforge.net/projects/ltl3ba/files/ltl3ba/1.0/ltl3ba-1.0.2.tar.gz'
  sha1 'd6a745a7c2712f7cc88ffc4f96b9574692e6fd47'

  depends_on 'buddy'

  def install
    inreplace 'Makefile', ' -static', ''
    system "make", "BUDDY_INCLUDE=#{HOMEBREW_PREFIX}/include/",
                   "BUDDY_LIB=#{HOMEBREW_PREFIX}/lib/"
    bin.install "ltl3ba"
  end
end
