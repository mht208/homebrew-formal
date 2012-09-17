require 'formula'

class Ocamlgraph < Formula
  homepage 'http://ocamlgraph.lri.fr'
  url 'http://ocamlgraph.lri.fr/download/ocamlgraph-1.8.2.tar.gz'
  sha1 'ff864aaae11f7355685f37815194ca58d3fcac01'

  option 'with-opt', 'Build native binaries and libraries'
  option 'with-doc', 'Install documentations'

  depends_on 'objective-caml'
  depends_on 'lablgtk2'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    system "./configure --prefix=#{prefix}"
    system "make"
    system "make opt" if build.include? 'with-opt'
    system "make doc" if build.include? 'with-doc'
    system "make install OCAMLLIB=#{prefix_stdlib}"
    system "make install-opt  OCAMLLIB=#{prefix_stdlib}" if build.include? 'with-opt'
    cp "META", "#{prefix_stdlib}/ocamlgraph"
    doc.install (Dir.glob "doc/*") if build.include? 'with-doc'
  end
end
