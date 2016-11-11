require 'formula'

class Lbtt < Formula
  homepage 'http://www.tcs.hut.fi/Software/lbtt/'
  url 'http://www.tcs.hut.fi/Software/lbtt/releases/1.2/lbtt-1.2.1.tar.gz'
  sha256 '6a660ca2e5832107555fa7c7c29801e4a008d040238c85634ab376a01881f7d9'

  def install
    ENV['CXX'] = "g++"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
