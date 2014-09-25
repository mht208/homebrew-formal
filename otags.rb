require 'formula'

class Otags < Formula
  homepage 'http://askra.de/software/otags/'
  url 'http://askra.de/software/otags/otags-4.01.1.tar.gz'
  sha1 'e22fa1171f1d458da04338e2a2ec70cffae4236c'

  depends_on 'objective-caml'

  def install
    system "./configure --prefix #{prefix}"
    system "make"
    system "make install"
  end
end
