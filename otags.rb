require 'formula'

class Otags < Formula
  homepage 'http://askra.de/software/otags/'
  url 'http://askra.de/software/otags/otags-4.01.1.tar.gz'
  sha256 '424f753187fc53557bcc78ad1586e92d64def4af9a31e21db87da559836f6a66'

  depends_on 'objective-caml'

  def install
    system "./configure --prefix #{prefix}"
    system "make"
    system "make install"
  end
end
