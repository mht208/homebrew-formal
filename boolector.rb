require 'formula'

class BoolectorDownloadStrategy < CurlDownloadStrategy
  alias super_stage :stage
  def stage
    super_stage
    # Unarchive boolector and lingeling.
    system "tar xf archives/lingeling*.tar.gz"
    system "mv lingeling* lingeling"
    system "tar xf archives/boolector*.tar.gz"
    system "mv boolector* boolector"
  end
end

class Boolector < Formula
  homepage 'http://fmv.jku.at/boolector/'
  url 'http://fmv.jku.at/boolector/boolector-2.0.0-with-lingeling-azd.tar.bz2', :using => BoolectorDownloadStrategy
  sha1 '8a3672712703716acf13af931357f566749595a6'

  depends_on 'minisat2' => :recommended
  depends_on 'picosat' => :recommended

  patch :DATA

  def install
    Dir.chdir 'lingeling' do
      system "./configure.sh"
      system "make"
    end
    Dir.chdir 'boolector' do
      args = ['-static']
      args << ((build.without? 'minisat2') ? '--no-minisat' : '--minisat')
      args << ((build.without? 'picosat') ? '--no-picosat' : '--picosat')
      system "./configure", *args
      system "make"
      system "make deltabtor"
      system "make libboolector.dylib"
    end
    bin.install "boolector/boolector", "boolector/deltabtor", "boolector/synthebtor"
    lib.install "boolector/libboolector.a", "boolector/libboolector.dylib"
    (include/'boolector').install Dir['boolector/*.h']
  end

end

__END__
diff --git a/boolector/configure b/boolector/configure
index e04471f..0fef4c3 100755
--- a/boolector/configure
+++ b/boolector/configure
@@ -124,7 +124,7 @@ fi
 #--------------------------------------------------------------------------#
 
 TARGETS="boolector"
-[ $shared = yes ] && TARGETS="$TARGETS libboolector.so"
+[ $shared = yes ] && TARGETS="$TARGETS libboolector.dylib"
 
 #--------------------------------------------------------------------------#
 
@@ -184,8 +184,8 @@ LIBM=no
 LIBSTDCPP=no
 if [ $shared = yes ]
 then
-  LIBS="-Wl\,-rpath=$(pwd)/."
-  LDEPS="libboolector.so"
+  LIBS="-Wl"
+  LDEPS="libboolector.dylib"
   LIBSTDCPP=yes
 fi
 
@@ -196,9 +196,9 @@ then
   msg "not using PicoSAT"
 else
 
-  if [ -d ../picosat ]
+  if [ -d /usr/local/lib ]
   then
-    for path in ../picosat/picosat.o ../picosat/version.o allfound
+    for path in /usr/local/include/picosat.h /usr/local/lib/libpicosat.a allfound
     do
       [ -f $path ] || break
     done
@@ -208,7 +208,7 @@ else
 
   if [ $path = allfound ]
   then
-    msg "using PicoSAT in '../picosat'"
+    msg "using PicoSAT in '/usr/local/lib/libpicosat.a'"
     picosat=yes
   elif [ $picosat = yes ]
   then
@@ -225,9 +225,9 @@ else
     [ X"$LDEPS" = X ] || LDEPS="$LDEPS "
     [ X"$LIBS" = X ] || LIBS="$LIBS "
     CFLAGS="${CFLAGS}-DBTOR_USE_PICOSAT"
-    LIBS="${LIBS}-L../picosat -Wl\,-rpath=$(pwd)/../picosat/ -lpicosat"
-    LDEPS="${LDEPS}../picosat/libpicosat.a"
-    INCS="${INCS}-I../picosat"
+    LIBS="${LIBS}-L/usr/local/lib -Wl -lpicosat"
+    LDEPS="${LDEPS}/usr/local/lib/libpicosat.a"
+    INCS="${INCS}-I/usr/local/include"
   fi
 fi
 
@@ -274,9 +274,9 @@ else
     INCS="${INCS}-I../lingeling"
   fi
 
-  if [ -d ../yalsat ]
+  if [ -d /usr/local/lib ]
   then
-    for path in ../yalsat/yals.h ../yalsat/libyals.a allfound
+    for path in /usr/local/include/lingeling/yals.h /usr/local/lib/libyals.a allfound
     do
       [ -f $path ] || break
     done
@@ -286,7 +286,7 @@ else
 
   if [ $path = allfound ]
   then
-    msg "using YalSAT in '../yalsat' too"
+    msg "using YalSAT in '/usr/local/lib/libyals.a' too"
     yalsat=yes
   else
     msg "not using YalSAT"
@@ -297,13 +297,15 @@ else
   then
     [ X"$LDEPS" = X ] || LDEPS="$LDEPS "
     [ X"$LIBS" = X ] || LIBS="$LIBS "
-    LIBS="${LIBS}-L../yalsat -lyals"
-    LDEPS="${LDEPS}../yalsat/libyals.a"
+    [ X"$INCS" = X ] || INCS="$INCS "
+    LIBS="${LIBS}-L/usr/local/lib -lyals"
+    LDEPS="${LDEPS}/usr/local/lib/libyals.a"
+    INCS="${INCS}-I/usr/local/include/lingeling"
   fi
 
-  if [ -d ../druplig ]
+  if [ -d /usr/local/lib ]
   then
-    for path in ../druplig/druplig.h ../druplig/libdruplig.a allfound
+    for path in /usr/local/include/lingeling/druplig.h /usr/local/lib/libdruplig.a allfound
     do
       [ -f $path ] || break
     done
@@ -313,7 +315,7 @@ else
 
   if [ $path = allfound ]
   then
-    msg "using Druplig in '../druplig' too"
+    msg "using Druplig in '/usr/local/lib/libdruplig.a' too"
     druplig=yes
   else
     msg "not using Druplig"
@@ -324,8 +326,10 @@ else
   then
     [ X"$LDEPS" = X ] || LDEPS="$LDEPS "
     [ X"$LIBS" = X ] || LIBS="$LIBS "
-    LIBS="${LIBS}-L../druplig -ldruplig"
-    LDEPS="${LDEPS}../druplig/libdruplig.a"
+    [ X"$INCS" = X ] || INCS="$INCS "
+    LIBS="${LIBS}-L/usr/local/lib -ldruplig"
+    LDEPS="${LDEPS}/usr/local/lib/libdruplig.a"
+    INCS="${INCS}-I/usr/local/include/lingeling"
   fi
 fi
 
@@ -337,10 +341,11 @@ then
 else
 
   for path in \
-    ../minisat \
-    ../minisat/minisat \
-    ../minisat/minisat/simp \
-    ../minisat/build/release \
+    /usr/local/include/minisat \
+    /usr/local/include/minisat/core \
+    /usr/local/include/minisat/mtl \
+    /usr/local/include/minisat/simp \
+    /usr/local/include/minisat/utils \
     allfound
   do
     [ -d $path ] || break
@@ -349,8 +354,8 @@ else
   if [ $path = allfound ]
   then
     for path in \
-      ../minisat/minisat/simp/SimpSolver.h \
-      ../minisat/build/release/lib/libminisat.a \
+      /usr/local/include/minisat/simp/SimpSolver.h \
+      /usr/local/lib/libminisat.a \
       allfound
     do
       [ -f $path ] || break
@@ -359,7 +364,7 @@ else
 
   if [ $path = allfound ]
   then
-    msg "using MiniSAT in '../minisat'"
+    msg "using MiniSAT in '/usr/local/lib/libminisat.a'"
     minisat=yes
   elif [ $minisat = yes ]
   then
@@ -379,16 +384,16 @@ else
     OBJS="${OBJS}btorminisat.o"
     if [ $shared = yes ]
     then
-      LIBS="${LIBS}-L../minisat/build/dynamic/lib -Wl\,-rpath=$(pwd)/../minisat/build/dynamic/lib -lminisat"
-      LDEPS="${LDEPS}../minisat/build/dynamic/lib/libminisat.so"
+      LIBS="${LIBS}-L/usr/local/lib -Wl -lminisat"
+      LDEPS="${LDEPS}/usr/local/lib/libminisat.dylib"
     else
-      LIBS="${LIBS}-L../minisat/build/release/lib -lminisat"
-      LDEPS="${LDEPS}../minisat/build/release/lib/libminisat.a"
+      LIBS="${LIBS}-L/usr/local/lib -lminisat"
+      LDEPS="${LDEPS}/usr/local/lib/libminisat.a"
     fi
     LIBSTDCPP=yes
     LIBZ=yes
     LIBM=yes
-    INCS="${INCS}-I../minisat"
+    INCS="${INCS}-I/usr/local/include"
   fi
 
 fi
@@ -454,7 +459,7 @@ ext_modules=[
               library_dirs=[cwd+"/"+s for s in "$py_library_dirs".split()],
               libraries="$py_libraries".split(),
               extra_compile_args=[s for s in "$CFLAGS".split() if "-D" in s],
-	      extra_link_args=["-Wl,-rpath="+":".join([cwd+"/"+s for s in "$py_library_dirs".split()])]
+	      extra_link_args=["-Wl"]
     )
 ]
 setup(cmdclass={'build_ext': build_ext}, ext_modules=ext_modules)
diff --git a/boolector/makefile.in b/boolector/makefile.in
index 5cf9595..309309f 100644
--- a/boolector/makefile.in
+++ b/boolector/makefile.in
@@ -45,10 +45,9 @@ libboolector.a: $(LIBOBJ)
 btorconfig.h: makefile VERSION mkconfig
 	rm -f $@; ./mkconfig > $@
 
-SONAME=-Xlinker -soname -Xlinker libboolector.so
 SHOBJS=$(filter-out ./btormbt.o ./btoruntrace.o ./btormain, $(LIBOBJ))
-libboolector.so: $(SHOBJS)
-	$(CC) $(CFLAGS) -shared -o $@ $(SHOBJS) $(LIBS) $(SONAME)
+libboolector.dylib: $(SHOBJS)
+	$(CC) $(CFLAGS) -shared -install_name $@ -o $@ $(SHOBJS) $(LIBS)
 
 clean:
 	rm -f $(TARGETS)

diff --git a/boolector/btorminisat.cc b/boolector/btorminisat.cc
index 2211460..f4f3014 100644
--- a/boolector/btorminisat.cc
+++ b/boolector/btorminisat.cc
@@ -19,7 +19,7 @@
 #define __STDC_FORMAT_MACROS
 #endif
 
-#include "../minisat/minisat/simp/SimpSolver.h"
+#include <minisat/simp/SimpSolver.h>
 
 #include <cassert>
 #include <cstring>

diff --git a/boolector/configure b/boolector/configure
index 0fef4c3..429e8bb 100755
--- a/boolector/configure
+++ b/boolector/configure
@@ -134,7 +134,7 @@ then
   CFLAGS="-W -Wall -Wextra"
   [ $arch = 32 ] && CFLAGS="$CFLAGS -m32"
   [ $arch = 64 ] && CFLAGS="$CFLAGS -m64"
-  [ $static = yes ] && CFLAGS="$CFLAGS -static"
+  [ $static = yes ] && CFLAGS="$CFLAGS"
   [ $shared = yes ] && CFLAGS="$CFLAGS -fPIC"
   if [ $debug = yes ]
   then

