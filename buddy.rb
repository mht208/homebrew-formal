require 'formula'

class Buddy < Formula
  homepage 'http://sourceforge.net/projects/buddy/'
  url 'http://sourceforge.net/projects/buddy/files/buddy/BuDDy%202.4/buddy-2.4.tar.gz'
  sha1 '0b58bb9f699593de148cd01b48656636eb4c0355'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
