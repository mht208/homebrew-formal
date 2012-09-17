require 'formula'

class Camlidl < Formula
  homepage 'http://caml.inria.fr/pub/old_caml_site/camlidl/'
  url 'http://caml.inria.fr/pub/old_caml_site/distrib/bazar-ocaml/camlidl-1.05.tar.gz'
  sha1 '2a0d5ba70fea8c1de1c5387f8b2058357b2177df'

  depends_on 'objective-caml'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    cp 'config/Makefile.unix', 'config/Makefile'
    system "make all"          
    mkdir_p "#{prefix_stdlib}/caml"
    mkdir "#{bin}"
    system "make install BINDIR=#{bin}/ OCAMLLIB=#{prefix_stdlib}"
  end
end
