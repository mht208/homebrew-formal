require 'formula'

class AltErgo < Formula
  homepage 'http://alt-ergo.lri.fr'
  url 'http://alt-ergo.lri.fr/http/alt-ergo-0.94.tar.gz'
  sha1 '52d32f5ba9ea1ce7bf90ce204d92571d1f62d6db'

  option 'with-gui', 'Build GUI'

  depends_on 'objective-caml'
  depends_on 'lablgtk2' if build.include? 'with-gui'

  def patches
    DATA
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--datarootdir=#{share}",
                          "--mandir=#{man}"
    system "make"
    system "make install"
    if build.include? 'with-gui'
      system "make gui"
      mkdir_p "#{share}/gtksourceview-2.0/language-specs"
      system "make install-gui"
    end
  end
end


__END__
diff --git a/Makefile.in b/Makefile.in
index 04a5b0e..6cbfa2d 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -208,7 +209,7 @@ install-man:
 install-gui: install-indep
 	mkdir -p $(BINDIR)
 	cp -f altgr-ergo.opt $(BINDIR)/altgr-ergo$(EXE)
-	cp -f util/gtk-lang/alt-ergo.lang /usr/share/gtksourceview-2.0/language-specs/alt-ergo.lang
+	cp -f util/gtk-lang/alt-ergo.lang @datarootdir@/gtksourceview-2.0/language-specs/alt-ergo.lang
 
 install-pack: xpack pack
 	mkdir -p $(LIBDIR)
