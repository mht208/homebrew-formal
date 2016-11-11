require 'formula'

class AltErgo < Formula
  homepage 'http://alt-ergo.lri.fr'
  url 'http://alt-ergo.ocamlpro.com/http/alt-ergo-0.95.2/alt-ergo-0.95.2.tar.gz'
  sha256 '5a6cd4349c144653be19a1ba4c254bbf626bdfd97c54d1c13ba63e396006eeac'

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
