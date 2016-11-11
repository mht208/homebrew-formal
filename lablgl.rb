require 'formula'

class Lablgl < Formula
  homepage 'https://forge.ocamlcore.org/projects/lablgl/'
  url 'https://forge.ocamlcore.org/frs/download.php/816/lablgl-20120306.tar.gz'
  sha256 '39017555724ca67807e73543b9fca1fcf9aab285f723635c9eee4034ac88adf0'

  depends_on :x11
  depends_on 'objective-caml'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    cp 'Makefile.config.osx', 'Makefile.config'
    system "make"
    system "make install LIBDIR=#{prefix_stdlib}"
  end
end
