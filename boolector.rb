require 'formula'

class BoolectorDownloadStrategy < CurlDownloadStrategy
  alias super_stage :stage
  def stage
    super_stage
    # Unarchive boolector and lingeling.
    `tar xf archives/lingeling*.tar.gz`
    `mv lingeling* lingeling`
    `tar xf archives/boolector*.tar.gz`
    `mv boolector* boolector`
  end
end

class Boolector < Formula
  homepage 'http://fmv.jku.at/boolector/'
  url 'http://fmv.jku.at/boolector/boolector-2.4.0-with-lingeling-bbc.tar.bz2', :using => BoolectorDownloadStrategy
  sha256 '5884c8b176e030363943014405dc317aff4da78da5f32ec6782a52142f519d9e'

  option 'with-python', 'Build with python api (not working)'

  depends_on 'minisat2' => :recommended
  depends_on 'picosat' => :optional
  depends_on :python => :optional
  depends_on 'Cython' => :python if build.with? 'python'

  patch :DATA

  def install
    pyver = `python --version 2>&1 | awk '{print $2}'`.chomp.gsub(/([0-9]+).([0-9]+).([0-9]+)/, '\1.\2')
    pylocal = lib/"python#{pyver}/site-packages"

    # Compile lingeling.
    Dir.chdir 'lingeling' do
      system "./configure.sh"
      system "make"
    end

    # Compile Boolector.
    Dir.chdir 'boolector' do
      args = ['-static', '--lingeling']
      args << ((build.with? 'python') ? '-python' : '')
      args << ((build.without? 'minisat2') ? '--no-minisat' : '--minisat')
      args << ((build.without? 'picosat') ? '--no-picosat' : '--picosat')
      system "./configure.sh", *args
      system "make"
      system "make build/libboolector.dylib"
    end

    # Install.
    Dir.chdir 'boolector' do
      bin.install "bin/boolector"
      lib.install "build/libboolector.a", "build/libboolector.dylib"
      (include/'boolector').install Dir['src/*.h']
      (include/'boolector'/'dumper').install Dir['src/dumper/*.h']
      (include/'boolector'/'parser').install Dir['src/parser/*.h']
      (include/'boolector'/'simplifier').install Dir['src/simplifier/*.h']
      (include/'boolector'/'utils').install Dir['src/utils/*.h']
      (share/'boolector').install 'doc', 'examples'
      if build.with? 'python'
        (share/'boolector').install 'src/api/python/api_usage_examples.py'
        (include/'boolector').install 'src/api/python/boolector_py.h'
        pylocal.install 'build/api/python/boolector_py.o',
                        'src/api/python/boolector.pyx',
                        'src/api/python/btorapi.pxd'
      end
    end
  end

end

__END__
diff --git a/boolector/configure.sh b/boolector/configure.sh
index c6b0493..8f32799 100755
--- a/boolector/configure.sh
+++ b/boolector/configure.sh
@@ -154,7 +154,7 @@ done
 #--------------------------------------------------------------------------#
 
 TARGETS="$BINDIR/boolector"
-[ $shared = yes ] && TARGETS="$TARGETS $BUILDIR/libboolector.so"
+[ $shared = yes ] && TARGETS="$TARGETS $BUILDIR/libboolector.dylib"
 
 #--------------------------------------------------------------------------#
 
@@ -164,7 +164,7 @@ then
   CFLAGS="-W -Wall -Wextra -Wredundant-decls"
   [ $arch = 32 ] && CFLAGS="$CFLAGS -m32"
   [ $arch = 64 ] && CFLAGS="$CFLAGS -m64"
-  [ $static = yes ] && CFLAGS="$CFLAGS -static"
+  [ $static = yes ] && CFLAGS="$CFLAGS"
   [ $shared = yes ] && CFLAGS="$CFLAGS -fPIC"
   if [ $debug = yes ]
   then
@@ -213,10 +213,10 @@ LDEPS="$BUILDIR/libboolector.a"
 LIBZ=no
 LIBM=no
 LIBSTDCPP=no
-RPATHS="-rpath\,$ROOT/$BUILDIR"
+RPATHS=""
 if [ $shared = yes ]
 then
-  LDEPS="$BUILDIR/libboolector.so"
+  LDEPS="$BUILDIR/libboolector.dylib"
   LIBSTDCPP=yes
 fi
 
@@ -227,28 +227,7 @@ then
   msg "not using PicoSAT"
 else
 
-  if [ -d $ROOT/../picosat ]
-  then
-    for path in $ROOT/../picosat/picosat.o $ROOT/../picosat/version.o allfound
-    do
-      [ -f $path ] || break
-    done
-  else
-    path=$ROOT/../picosat
-  fi
-
-  if [ $path = allfound ]
-  then
-    msg "using PicoSAT in '$ROOT/../picosat'"
-    picosat=yes
-  elif [ $picosat = yes ]
-  then
-    die "impossible to use PicoSAT: '$path' missing"
-  else
-    msg "disabling PicoSAT: '$path' missing"
-    picosat=no
-  fi
-
+  picosat=yes
   if [ $picosat = yes ]
   then
     [ X"$CFLAGS" = X ] || CFLAGS="$CFLAGS "
@@ -256,16 +235,16 @@ else
     [ X"$LDEPS" = X ] || LDEPS="$LDEPS "
     [ X"$LIBS" = X ] || LIBS="$LIBS "
     CFLAGS="${CFLAGS}-DBTOR_USE_PICOSAT"
-    RPATHS="${RPATHS}\,-rpath\,$ROOT/../picosat/"
+    RPATHS="${RPATHS}"
     if [ $shared = yes ]		
     then
-      LIBS="${LIBS}-L$ROOT/../picosat -lpicosat"
-      LDEPS="${LDEPS}$ROOT/../picosat/libpicosat.so"
+      LIBS="${LIBS}-L/usr/local/lib -lpicosat"
+      LDEPS="${LDEPS}/usr/local/lib/libpicosat.dylib"
     else
-      LIBS="${LIBS}-L$ROOT/../picosat -lpicosat"
-      LDEPS="${LDEPS}$ROOT/../picosat/libpicosat.a"
+      LIBS="${LIBS}-L/usr/local/lib -lpicosat"
+      LDEPS="${LDEPS}/usr/local/lib/libpicosat.a"
     fi
-    INCS="${INCS}-I$ROOT/../picosat"
+    INCS="${INCS}-I/usr/local/include"
   fi
 fi
 
@@ -373,38 +352,7 @@ then
   msg "not using MiniSAT"
 else
 
-  for path in \
-    $ROOT/../minisat \
-    $ROOT/../minisat/minisat \
-    $ROOT/../minisat/minisat/simp \
-    $ROOT/../minisat/build/release \
-    allfound
-  do
-    [ -d $path ] || break
-  done
-
-  if [ $path = allfound ]
-  then
-    for path in \
-      $ROOT/../minisat/minisat/simp/SimpSolver.h \
-      $ROOT/../minisat/build/release/lib/libminisat.a \
-      allfound
-    do
-      [ -f $path ] || break
-    done
-  fi
-
-  if [ $path = allfound ]
-  then
-    msg "using MiniSAT in '$ROOT/../minisat'"
-    minisat=yes
-  elif [ $minisat = yes ]
-  then
-    die "impossible to use MiniSAT: '$path' missing"
-  else
-    msg "disabling MiniSAT: '$path' missing"
-  fi
-
+  minisat=yes
   if [ $minisat = yes ]
   then
     [ X"$CFLAGS" = X ] || CFLAGS="$CFLAGS "
@@ -414,19 +362,19 @@ else
     [ X"$INCS" = X ] || INCS="$INCS "
     CFLAGS="${CFLAGS}-DBTOR_USE_MINISAT"
     OBJS="${OBJS}$BUILDIR/btorminisat.o"
-    RPATHS="${RPATHS}\,-rpath\,$ROOT/../minisat/build/dynamic/lib"
+    RPATHS="${RPATHS}"
     if [ $shared = yes ]
     then
-      LIBS="${LIBS}-L$ROOT/../minisat/build/dynamic/lib -lminisat"
-      LDEPS="${LDEPS}$ROOT/../minisat/build/dynamic/lib/libminisat.so"
+      LIBS="${LIBS}-L/usr/local/lib -lminisat"
+      LDEPS="${LDEPS}/usr/local/lib/libminisat.dylib"
     else
-      LIBS="${LIBS}-L$ROOT/../minisat/build/release/lib -lminisat"
-      LDEPS="${LDEPS}$ROOT/../minisat/build/release/lib/libminisat.a"
+      LIBS="${LIBS}-L/usr/local/lib -lminisat"
+      LDEPS="${LDEPS}/usr/local/lib/libminisat.a"
     fi
     LIBSTDCPP=yes
     LIBZ=yes
     LIBM=yes
-    INCS="${INCS}-I$ROOT/../minisat"
+    INCS="${INCS}-I/usr/local/include"
   fi
 
 fi
@@ -462,7 +410,7 @@ fi
 
 #--------------------------------------------------------------------------#
 
-LIBS="-Wl\,${RPATHS} ${LIBS}"
+LIBS="-Wl ${LIBS}"
 
 if [ $python = yes ]
 then
@@ -482,13 +430,13 @@ then
   fi
   if [ $picosat = yes ]; then
     py_libraries="$py_libraries picosat"
-    py_library_dirs="$py_library_dirs $ROOT/../picosat"
-    py_inc_dirs="$py_inc_dirs $ROOT/../picosat"
+    py_library_dirs="$py_library_dirs /usr/local/lib"
+    py_inc_dirs="$py_inc_dirs /usr/local/include"
   fi
   if [ $minisat = yes ]; then
     py_libraries="$py_libraries minisat"
-    py_library_dirs="$py_library_dirs $ROOT/../minisat/build/dynamic/lib"
-    py_inc_dirs="$py_inc_dirs $ROOT/../minisat/build/dynamic/lib"
+    py_library_dirs="$py_library_dirs /usr/local/lib"
+    py_inc_dirs="$py_inc_dirs /usr/local/include"
   fi
   OBJS="$BUILDIR/api/python/boolector_py.o $OBJS" 
   pyinc=`$PYTHON -c "import sysconfig; print(sysconfig.get_config_var('CONFINCLUDEPY'))"`
@@ -511,7 +459,7 @@ ext_modules=[
               library_dirs=[s for s in "$py_library_dirs".split()],
               libraries="$py_libraries".split(),
               extra_compile_args=[s for s in "$CFLAGS".split() if "-D" in s],
-       extra_link_args=["-Wl,-rpath,"+":".join([s for s in "$py_library_dirs".split()])]
+       extra_link_args=["-Wl"]
     )
 ]
 setup(cmdclass={'build_ext': build_ext}, ext_modules=ext_modules)
diff --git a/boolector/makefile.in b/boolector/makefile.in
index aebdfa5..78ec5f0 100644
--- a/boolector/makefile.in
+++ b/boolector/makefile.in
@@ -61,8 +61,8 @@ $(BUILDIR)/libboolector.a: $(LIBOBJS)
 	ranlib $@
 
 SHOBJS=$(filter-out $(BUILDIR)/btormbt.o $(BUILDIR)/btoruntrace.o $(BUILDIR)/btormain.o $(BUILDIR)/boolectormain.o, $(LIBOBJS))
-$(BUILDIR)/libboolector.so: $(SHOBJS)
-	$(CC) $(CFLAGS) -shared -o $@ $(SHOBJS) $(LIBS) -Xlinker -soname=libboolector.so
+$(BUILDIR)/libboolector.dylib: $(SHOBJS)
+	$(CC) $(CFLAGS) -shared -install_name $@ -o $@ $(SHOBJS) $(LIBS)
 
 $(BINDIR)/boolector: $(BUILDIR)/btormain.o $(BUILDIR)/boolectormain.o $(LDEPS)
 	@mkdir -p $(@D)
diff --git a/boolector/src/btorminisat.cc b/boolector/src/btorminisat.cc
index d7a0791..bec7d9a 100644
--- a/boolector/src/btorminisat.cc
+++ b/boolector/src/btorminisat.cc
@@ -20,7 +20,7 @@
 #define __STDC_FORMAT_MACROS
 #endif
 
-#include "../minisat/minisat/simp/SimpSolver.h"
+#include <minisat/simp/SimpSolver.h>
 
 #include <cassert>
 #include <cstring>

