require 'formula'

class Ltl3ba < Formula
  homepage 'http://sourceforge.net/projects/ltl3ba/'
  url 'https://sourceforge.net/projects/ltl3ba/files/ltl3ba/1.1/ltl3ba-1.1.3.tar.gz/download'
  sha256 'fd1424fe1bd0381d662ebe3c8088076475b23dd5f20ba2a3f3fae6c69c08ce5b'

  depends_on 'buddy'

  def install
    system "make", "BUDDY_INCLUDE=#{HOMEBREW_PREFIX}/include/",
                   "BUDDY_LIB=#{HOMEBREW_PREFIX}/lib/"
    bin.install "ltl3ba"
  end
end
