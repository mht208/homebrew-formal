require 'formula'

class Lbtt < Formula
  homepage 'http://www.tcs.hut.fi/Software/lbtt/'
  url 'http://www.tcs.hut.fi/Software/lbtt/releases/1.2/lbtt-1.2.1.tar.gz'
  sha1 'ab5f96d54dee664bb6c618f9a4dad23a80069bfa'

  def install
    ENV['CXX'] = "g++"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
