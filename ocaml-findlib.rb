require 'formula'

class OcamlFindlib < Formula
  homepage 'http://projects.camlcity.org/projects/findlib.html'
  url 'http://download.camlcity.org/download/findlib-1.5.3.tar.gz'
  sha1 'd0d0d80f7ad0f4fa102b3d7454178fb7445af173'

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
