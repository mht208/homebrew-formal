require 'formula'

class Zarith < Formula
  homepage 'http://forge.ocamlcore.org/projects/zarith'
  url 'http://forge.ocamlcore.org/frs/download.php/1199/zarith-1.2.1.tgz'
  sha256 '916801cc39599d3fca07384fbfeec4bfaa5ffcb497d68ef89320af40ba5e4144'

  depends_on 'objective-caml'
  depends_on 'gmp'

  def install
    system "./configure"
    system "make"

    # Installation with ocamlfind will fail to update ld.conf
    system "make", "INSTMETH=install", "INSTALLDIR=#{prefix}/lib/ocaml", "install"

    (lib/'ocaml/zarith').install "META"
  end

end
