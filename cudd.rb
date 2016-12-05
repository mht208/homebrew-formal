require 'formula'

class Cudd < Formula
  homepage 'http://vlsi.colorado.edu/~fabio/CUDD/'
  url 'ftp://vlsi.colorado.edu/pub/cudd-3.0.0.tar.gz'
  sha256 'b8e966b4562c96a03e7fbea239729587d7b395d53cadcc39a7203b49cf7eeb69'

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-shared", "--enable-dddmp", "--enable-obj"
    system "make"
    system "make", "install"
  end

end
