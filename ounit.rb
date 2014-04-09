require 'formula'

class Ounit < Formula
  homepage 'http://ounit.forge.ocamlcore.org'
  url 'http://forge.ocamlcore.org/frs/download.php/1258/ounit-2.0.0.tar.gz'
  sha1 '28e558f810611acb49eac8920fa354997d3db6f5'

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
