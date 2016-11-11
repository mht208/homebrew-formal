require 'formula'

class Picosat < Formula
  homepage 'http://fmv.jku.at/picosat/'
  url 'http://fmv.jku.at/picosat/picosat-960.tar.gz'
  sha256 'edb3184a04766933b092713d0ae5782e4a3da31498629f8bb2b31234a563e817'

  def patches
    # Fix the dynamic shared library.
    DATA
  end

  def install
    system "./configure -shared"
    system "make"
    bin.install "picosat", "picogcnf", "picomcs", "picomus"
    lib.install "libpicosat.a", "libpicosat.dylib"
    include.install "picosat.h"
  end
end


__END__
diff --git a/configure b/configure
index ca5ec77..fe9e162 100755
--- a/configure
+++ b/configure
@@ -108,7 +108,7 @@ fi
 TARGETS="picosat picomcs picomus picogcnf libpicosat.a"
 if [ $shared = yes ]
 then
-  TARGETS="$TARGETS libpicosat.so"
+  TARGETS="$TARGETS libpicosat.dylib"
   CFLAGS="$CFLAGS -fPIC"
 fi
 echo "targets ... $TARGETS"
diff --git a/makefile.in b/makefile.in
index 2eb0af2..76ffa05 100644
--- a/makefile.in
+++ b/makefile.in
@@ -52,8 +52,7 @@ libpicosat.a: picosat.o version.o
 	ar rc $@ picosat.o version.o
 	ranlib $@
 
-SONAME=-Xlinker -soname -Xlinker libpicosat.so
-libpicosat.so: picosat.o version.o
-	$(CC) $(CFLAGS) -shared -o $@ picosat.o version.o $(SONAME)
+libpicosat.dylib: picosat.o version.o
+	$(CC) $(CFLAGS) -shared -install_name $@ -o $@ picosat.o version.o
 
 .PHONY: all clean
