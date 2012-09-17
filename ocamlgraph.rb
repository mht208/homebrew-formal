require 'formula'

class Ocamlgraph < Formula
  homepage 'http://ocamlgraph.lri.fr'
  url 'http://ocamlgraph.lri.fr/download/ocamlgraph-1.8.2.tar.gz'
  sha1 'ff864aaae11f7355685f37815194ca58d3fcac01'

  depends_on 'objective-caml'
  depends_on 'lablgtk2'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    system "./configure --prefix=#{prefix}"
    system "make"
    system "make install OCAMLLIB=#{prefix_stdlib}"
    cp "META", "#{prefix_stdlib}/ocamlgraph"
  end
end
