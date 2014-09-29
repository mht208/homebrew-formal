require 'formula'

class AltErgo < Formula
  homepage 'http://alt-ergo.lri.fr'
  url 'http://alt-ergo.ocamlpro.com/http/alt-ergo-0.95.2/alt-ergo-0.95.2.tar.gz'
  sha1 '6555c40ba9d5690e98093c1ed2b53090e6f35ef2'

  option 'with-gui', 'Install graphical user interface'

  depends_on 'objective-caml'
  depends_on 'ocamlgraph'
  depends_on 'lablgtk2' if build.with? 'gui'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
    if build.with? 'gui'
      system "make gui"
      system "make install-gui"
    end
  end
end
