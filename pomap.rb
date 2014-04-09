require 'formula'

class Pomap < Formula
  homepage 'https://bitbucket.org/mmottl/pomap/downloads'
  url 'https://bitbucket.org/mmottl/pomap/downloads/pomap-3.0.3.tar.gz'
  sha1 'a1536048e23e565b0886887d3d5dd4dd0687387f'

  depends_on 'objective-caml'
  depends_on 'ocaml-findlib'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    # Fix the installation path.
    inreplace "setup.ml", "\"install\" ::",
              "\"install\" :: \"-destdir\" :: \"#{prefix_stdlib}\" ::"

    system "ocaml setup.ml -configure --prefix #{prefix} --destdir #{prefix}"
    system "ocaml setup.ml -build"

    # The ocaml library directory should be created before the installaion
    # by ocamlfind.
    mkdir_p "#{prefix_stdlib}"

    system "ocaml setup.ml -install"
  end
end
