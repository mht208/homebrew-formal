require 'formula'

class AltErgo < Formula
  homepage 'http://alt-ergo.lri.fr'
  url 'http://alt-ergo.lri.fr/http/alt-ergo-0.95.1/alt-ergo-0.95.1.tar.gz'
  sha1 'eae5cc58bc28bbfd369f5c6ef8f767c835ec9ce9'

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
  end
end


__END__
diff --git a/Makefile.in b/Makefile.in
index f7b0f59..a42cae8 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -245,8 +245,8 @@ install: install-indep
 	cp -f $(NAME).$(OCAMLBEST) $(BINDIR)/$(NAME)$(EXE)
 ifeq ($(ENABLEGUI),yes)
 	cp -f altgr-ergo.opt $(BINDIR)/altgr-ergo$(EXE)
-	mkdir -p $(DATADIR)/gtksourceview-2.0/language-specs
-	cp -f util/gtk-lang/alt-ergo.lang $(DATADIR)/gtksourceview-2.0/language-specs/alt-ergo.lang
+	mkdir -p @datarootdir@/gtksourceview-2.0/language-specs
+	cp -f util/gtk-lang/alt-ergo.lang @datarootdir@/gtksourceview-2.0/language-specs/alt-ergo.lang
 endif
 
 install-pack: xpack pack META

