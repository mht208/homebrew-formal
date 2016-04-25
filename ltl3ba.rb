require 'formula'

class Ltl3ba < Formula
  homepage 'http://sourceforge.net/projects/ltl3ba/'
  url 'https://sourceforge.net/projects/ltl3ba/files/ltl3ba/1.1/ltl3ba-1.1.2.tar.gz'
  sha256 '42ae878b43acd7a712b1bad834beb4ff21319f88486451bd8d8d9450b6089779'

  depends_on 'buddy'

  def install
    system "make", "BUDDY_INCLUDE=#{HOMEBREW_PREFIX}/include/",
                   "BUDDY_LIB=#{HOMEBREW_PREFIX}/lib/"
    bin.install "ltl3ba"
  end
end
