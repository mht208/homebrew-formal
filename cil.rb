require 'formula'

class Cil < Formula
  homepage 'http://kerneis.github.com/cil/'
  url 'http://sourceforge.net/projects/cil/files/cil/cil-1.5.1.tar.gz'
  sha1 '3e1112c2a440e8ae8e04e82fb4e85988694d6c26'

  depends_on "objective-caml"
  depends_on "ocaml-findlib"

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    system "./configure", "--prefix=#{prefix}"

    # Fix the installation path.
    chmod 0644, "Makefile"
    inreplace "Makefile", "ocamlfind install", 
              "ocamlfind install -destdir #{prefix_stdlib}"

    system "make"

    # The ocaml library directory should be created before the installaion
    # by ocamlfind.
    mkdir_p "#{prefix_stdlib}"

    system "make install"
  end

end
