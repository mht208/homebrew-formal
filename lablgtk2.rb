require 'formula'

class Lablgtk2 < Formula
  homepage 'wwwfun.kurims.kyoto-u.ac.jp/soft/lsl/lablgtk.html'
  url 'https://forge.ocamlcore.org/frs/download.php/979/lablgtk-2.16.0.tar.gz'
  sha1 '3dec411a410fbb38d6e2e5a43a4ebfb2e407e7e6'

  option 'with-glade', 'Build with libglade support'
  option 'with-rsvg', 'Build with librsvg support'
  option 'with-gnomecanvas', 'Build with libgnomecanvas support'
  option 'with-gtksourceview2', 'Build with gtksourceview2 support'

  depends_on 'pkg-config' => :build
  depends_on :x11
  depends_on 'objective-caml'
  depends_on 'gtk+'
  depends_on 'ocaml-findlib'
  depends_on 'libglade' if build.include? 'with-glade'
  depends_on 'librsvg' if build.include? 'with-rsvg'
  depends_on 'libgnomecanvas' if build.include? 'with-gnomecanvas'
  depends_on 'gtksourceview' if build.include? 'with-gtksourceview2'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    ENV.j1
    args = ["--bindir=#{bin}",
            "--libdir=#{lib}",
            "--mandir=#{man}",
            "--with-libdir=#{lib}/ocaml"]
    args << ((build.include? 'with-glade') ? '--with-glade' : '--without-glade')
    args << ((build.include? 'with-rsvg') ? '--with-rsvg' : '--without-rsvg')
    args << ((build.include? 'with-gnomecanvas') ? '--with-gnomecanvas' : '--without-gnomecanvas')
    args << ((build.include? 'with-gtksourceview2') ?  '--with-gtksourceview2' : '--without-gtksourceview2')
    system "./configure", *args
    inreplace 'src/Makefile', 'ocamlfind install',
              "ocamlfind install -destdir #{prefix_stdlib} -ldconf #{prefix_stdlib}/lablgtk2/ld.conf"
    inreplace 'src/Makefile', 'ocamlfind query lablgtk2',
              "echo #{prefix_stdlib}/lablgtk2"
    system "make world"
    mkdir_p "#{prefix_stdlib}"
    system "make install"
  end
end
