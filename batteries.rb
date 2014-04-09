require 'formula'

class Batteries < Formula
  homepage 'http://batteries.forge.ocamlcore.org'
  url 'https://forge.ocamlcore.org/frs/download.php/1363/batteries-2.2.tar.gz'
  sha1 '5cae96ec9dfa00af7120ce625be5696df1a98b3d'

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
