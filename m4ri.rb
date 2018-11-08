require 'formula'

class M4ri < Formula
  desc 'a library for fast arithmetic with dense matrices over F2'
  homepage 'https://bitbucket.org/malb/m4ri'
  head 'https://bitbucket.org/malb/m4ri', :using => :git, :revision => '7a76a40'
  version '7a76a40'

  depends_on "autoconf"
  depends_on "automake"
  depends_on "libtool"

  def install
    system "autoreconf --install"
    system "./configure --prefix=#{prefix} --enable-openmp"
    system "make"
    system "make install"
  end

end
