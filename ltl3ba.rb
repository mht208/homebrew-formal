require 'formula'

class Ltl3ba < Formula
  homepage 'http://sourceforge.net/projects/ltl3ba/'
  url 'http://sourceforge.net/projects/ltl3ba/files/ltl3ba/1.0/ltl3ba-1.0.1.tar.gz'
  sha1 'b12a1f70d0cddb3e27e1eab05afda0f4d01282e8'

  depends_on 'buddy'

  def install
    inreplace 'Makefile', ' -static', ''
    system "make", "BUDDY_INCLUDE=#{HOMEBREW_PREFIX}/include/",
                   "BUDDY_LIB=#{HOMEBREW_PREFIX}/lib/"
    bin.install "ltl3ba"
  end
end
