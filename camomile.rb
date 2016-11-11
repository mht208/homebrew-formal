require 'formula'

class Camomile < Formula
  homepage 'https://github.com/yoriyuki/Camomile'
  url 'https://github.com/yoriyuki/Camomile/releases/download/rel-0.8.5/camomile-0.8.5.tar.bz2'
  sha256 '85806b051cf059b93676a10a3f66051f7f322cad6e3248172c3e5275f79d7100'

  depends_on 'objective-caml'
  depends_on 'ocaml-findlib'
  depends_on 'coreutils'

  def install
    ENV.deparallelize
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    # Fix the installation path.
    inreplace "Makefile.in", "ocamlfind install",
              "ocamlfind install -destdir #{prefix_stdlib}"

    system "./configure --prefix=#{prefix}"
    system "make"

    # The ocaml library directory should be created before the installaion
    # by ocamlfind.
    mkdir_p "#{prefix_stdlib}"

    system "make install"
  end
end
