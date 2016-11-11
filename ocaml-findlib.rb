require 'formula'

class OcamlFindlib < Formula
  homepage 'http://projects.camlcity.org/projects/findlib.html'
  url 'http://download.camlcity.org/download/findlib-1.5.3.tar.gz'
  sha256 'd920816e48cb5bf3199fb57b78e30c2c1ea0e5eeeff654810118b14b76d482cf'

  depends_on 'objective-caml'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix
    system "./configure", "-bindir", bin,
                          "-mandir", man,
                          "-sitelib", "#{prefix_stdlib}",
                          "-config", "#{prefix}/etc/findlib.conf"
    system "make all"
    system "make opt"
    # Set the library path to `ocamlc where`
    inreplace "findlib.conf", prefix_stdlib, homebrew_prefix_stdlib
    system "make install OCAML_CORE_STDLIB=#{prefix}/lib/ocaml"
  end

end
