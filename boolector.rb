require 'formula'

class Boolector < Formula
  homepage 'http://fmv.jku.at/boolector/'
  url 'http://fmv.jku.at/boolector/boolector-1.5.118-6b56be4-121013.tar.gz'
  sha1 'b136e73313e402c65cb3819e03f397dd3b218756'

  depends_on 'lingeling'
  depends_on 'picosat'
  # Failed to build with minisat even __STDC_FORMAT_MACROS is enabled
  # and inttypes.h is included. Don't know why.
#  depends_on 'mht208/formal/minisat'

  def patches
    DATA
  end

  def install
    system "./configure", "--lingeling", "--picosat"
    system "make"
    bin.install "boolector", "deltabtor", "synthebtor"
    lib.install "libboolector.a"
    include.install Dir['*.h']
  end

end


__END__
diff --git a/btorexp.c b/btorexp.c
index 5c4e913..3eb5e2b 100644
--- a/btorexp.c
+++ b/btorexp.c
@@ -8314,7 +8314,7 @@ BTOR_SPLIT_SLICES_RESTART:
 #ifndef BTOR_DO_NOT_PROCESS_SKELETON
 /*------------------------------------------------------------------------*/
 
-#include "../lingeling/lglib.h"
+#include "lglib.h"
 
 static int
 btor_fixed_exp (Btor * btor, BtorNode * exp)
diff --git a/btorsat.c b/btorsat.c
index f9e781b..02f7358 100644
--- a/btorsat.c
+++ b/btorsat.c
@@ -10,11 +10,11 @@
  */
 
 #ifdef BTOR_USE_PICOSAT
-#include "../picosat/picosat.h"
+#include "picosat.h"
 #endif
 
 #ifdef BTOR_USE_LINGELING
-#include "../lingeling/lglib.h"
+#include "lglib.h"
 #endif
 
 #ifdef BTOR_USE_MINISAT
diff --git a/configure b/configure
index 8318348..b948471 100755
--- a/configure
+++ b/configure
@@ -147,19 +147,19 @@ then
   msg "not using PicoSAT"
 else
 
-  if [ -d ../picosat ]
+  if [ -d /usr/local/opt/picosat ]
   then
-    for path in ../picosat/picosat.o ../picosat/version.o allfound
+    for path in /usr/local/lib/libpicosat.a allfound
     do
       [ -f $path ] || break
     done
   else
-    path=../picosat
+    path=/usr/local/lib
   fi
 
   if [ $path = allfound ]
   then
-    msg "using PicoSAT in '../picosat'"
+    msg "using PicoSAT in '/usr/local/lib'"
     [ X"$OBJS" = X ] || OBJS="$OBJS "
     picosat=yes
   elif [ $picosat = yes ]
@@ -173,9 +173,11 @@ else
   if [ $picosat = yes ]
   then
     [ X"$CFLAGS" = X ] || CFLAGS="$CFLAGS "
-    [ X"$OBJS" = X ] || OBJS="$OBJS "
+    [ X"$LDEPS" = X ] || LDEPS="$LDEPS "
+    [ X"$LIBS" = X ] || LIBS="$LIBS "
     CFLAGS="${CFLAGS}-DBTOR_USE_PICOSAT"
-    OBJS="${OBJS}../picosat/picosat.o ../picosat/version.o"
+    LIBS="${LIBS}-L/usr/local/lib -lpicosat"
+    LDEPS="${LDEPS}/usr/local/lib/libpicosat.a"
   fi
 fi
 
@@ -186,19 +188,19 @@ then
   msg "not using Lingeling as requested by command line option"
 else
 
-  if [ -d ../lingeling ]
+  if [ -d /usr/local/opt/lingeling ]
   then
-    for path in ../lingeling/lglib.h ../lingeling/liblgl.a allfound
+    for path in /usr/local/include/lglib.h /usr/local/lib/liblgl.a allfound
     do
       [ -f $path ] || break
     done
   else
-    path=../lingeling
+    path=/usr/local/lib
   fi
 
   if [ $path = allfound ]
   then
-    msg "using Lingeling in '../lingeling'"
+    msg "using Lingeling in '/usr/local/lib'"
     lingeling=yes
   elif [ $lingeling = yes ]
   then
@@ -213,9 +215,9 @@ else
     [ X"$CFLAGS" = X ] || CFLAGS="$CFLAGS "
     [ X"$LDEPS" = X ] || LDEPS="$LDEPS "
     [ X"$LIBS" = X ] || LIBS="$LIBS "
-    CFLAGS="${CFLAGS}-DBTOR_USE_LINGELING"
-    LIBS="${LIBS}-L../lingeling -llgl"
-    LDEPS="${LDEPS}../lingeling/liblgl.a"
+    CFLAGS="${CFLAGS}-DBTOR_USE_LINGELING -I/usr/local/include"
+    LIBS="${LIBS}-L/usr/local/lib -llgl"
+    LDEPS="${LDEPS}/usr/local/lib/liblgl.a"
     LIBM=yes
   fi
 
@@ -228,12 +230,7 @@ then
   msg "not using MiniSAT"
 else
 
-  for path in \
-    ../minisat \
-    ../minisat/minisat \
-    ../minisat/minisat/simp \
-    ../minisat/build/release \
-    allfound
+  for path in /usr/local/opt/minisat_disabled allfound
   do
     [ -d $path ] || break
   done
@@ -241,8 +238,8 @@ else
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
@@ -251,7 +248,7 @@ else
 
   if [ $path = allfound ]
   then
-    msg "using MiniSAT in '../minisat'"
+    msg "using MiniSAT in '/usr/local/lib'"
     minisat=yes
   elif [ $minisat = yes ]
   then
@@ -266,10 +263,10 @@ else
     [ X"$OBJS" = X ] || OBJS="$OBJS "
     [ X"$LDEPS" = X ] || LDEPS="$LDEPS "
     [ X"$LIBS" = X ] || LIBS="$LIBS "
-    CFLAGS="${CFLAGS}-DBTOR_USE_MINISAT -I../minisat"
+    CFLAGS="${CFLAGS}-DBTOR_USE_MINISAT -I/usr/local/include/minisat -D __STDC_LIMIT_MACROS -D __STDC_FORMAT_MACROS"
     OBJS="${OBJS}btorminisat.o"
-    LIBS="${LIBS}-L../minisat/build/release/lib -lminisat"
-    LDEPS="${LDEPS}../minisat/build/release/lib/libminisat.a"
+    LIBS="${LIBS}-L/usr/local/lib -lminisat"
+    LDEPS="${LDEPS}/usr/local/lib/libminisat.a"
     LIBSTDCPP=yes
     LIBZ=yes
   fi
diff --git a/btorminisat.cc b/btorminisat.cc
index 166f36a..11f16ac 100644
--- a/btorminisat.cc
+++ b/btorminisat.cc
@@ -17,7 +17,7 @@
 #define __STDC_FORMAT_MACROS
 #endif
 
-#include "../minisat/minisat/simp/SimpSolver.h"
+#include "SimpSolver.h"
 
 extern "C" {

