require 'formula'

class Cudd < Formula
  desc 'CUDD is a package written in C for the manipulation of decision diagrams. Note that the official website of CUDD is down. This formula will install CUDD from an unofficial mirror on GitHub.'
  homepage 'http://vlsi.colorado.edu/~fabio/CUDD/'
  url 'https://github.com/ivmai/cudd/archive/cudd-3.0.0.tar.gz'
  sha256 '5fe145041c594689e6e7cf4cd623d5f2b7c36261708be8c9a72aed72cf67acce'

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-shared", "--enable-dddmp", "--enable-obj"
    system "make"
    system "make", "install"
  end

end
