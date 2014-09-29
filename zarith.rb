require 'formula'

class Zarith < Formula
  homepage 'http://forge.ocamlcore.org/projects/zarith'
  url 'http://forge.ocamlcore.org/frs/download.php/1199/zarith-1.2.1.tgz'
  sha1 '4ffeddb18e56653c85cde68a5755a3a024282330'

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
