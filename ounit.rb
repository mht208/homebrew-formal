require 'formula'

class Ounit < Formula
  homepage 'http://ounit.forge.ocamlcore.org'
  url 'http://forge.ocamlcore.org/frs/download.php/1258/ounit-2.0.0.tar.gz'
  sha256 '4d4a05b20c39c60d7486fb7a90eb4c5c08e8c9862360b5938b97a09e9bd21d85'

  depends_on 'objective-caml'
  depends_on 'ocaml-findlib'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    # Fix the installation path.
    inreplace "setup.ml", "\"install\" ::",
              "\"install\" :: \"-destdir\" :: \"#{prefix_stdlib}\" ::"

    system "./configure --prefix #{prefix} --destdir #{prefix}"
    system "make"

    # The ocaml library directory should be created before the installaion
    # by ocamlfind.
    mkdir_p "#{prefix_stdlib}"

    system "make install"
  end
end
