require 'formula'

class Buddy < Formula
  homepage 'http://sourceforge.net/projects/buddy/'
  url 'http://sourceforge.net/projects/buddy/files/buddy/BuDDy%202.4/buddy-2.4.tar.gz'
  sha256 'd3df80a6a669d9ae408cb46012ff17bd33d855529d20f3a7e563d0d913358836'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
