require 'formula'

class OcamlCurses < Formula
  homepage 'http://www.nongnu.org/ocaml-tmk/'
  url 'http://download.savannah.gnu.org/releases/ocaml-tmk/ocaml-curses-1.0.3.tar.gz'
  sha1 '6bcb4a6eaf8353aac93069be0084f833a55340c1'

  depends_on "objective-caml"
  depends_on "autoconf"

  def install
    system "autoconf"
    system "touch",  "config.h.in"
    system "./configure"
    system "make"
    system "make", "opt"
    (lib/'ocaml/curses').install 'META', 'curses.cma', 'curses.cmxa', 'curses.cmi', 'curses.mli', 'dllcurses_stubs.so', 'curses.a', 'libcurses_stubs.a'
  end
end
