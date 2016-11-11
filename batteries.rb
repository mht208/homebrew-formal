require 'formula'

class Batteries < Formula
  homepage 'http://batteries.forge.ocamlcore.org'
  url 'https://forge.ocamlcore.org/frs/download.php/1363/batteries-2.2.tar.gz'
  sha256 '7a7139ffa0c0da356a3be63a1024eb15f15eaf6d396b999565e77f77ca789c7c'

  depends_on 'objective-caml'
  depends_on 'ocaml-findlib'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    # Fix the installation path.
    inreplace "Makefile", "ocamlfind install",
              "ocamlfind install -destdir #{prefix_stdlib}"

    system "make"

    # The ocaml library directory should be created before the installaion
    # by ocamlfind.
    mkdir_p "#{prefix_stdlib}"

    system "make install"
  end
end
