require 'formula'

class Aiger < Formula
  homepage 'http://fmv.jku.at/aiger/'
  url 'http://fmv.jku.at/aiger/aiger-1.9.9.tar.gz'
  sha1 '80f612b650b5b82a71be2ed942420eff412dec6d'

  depends_on 'picosat'

  def patches
    DATA
  end

  def install
    system "./configure.sh"
    system "make"
    bin.install "aigand", "aigbmc", "aigdd", "aigdep", "aigflip",
                "aigfuzz", "aiginfo", "aigjoin", "aigmiter", "aigmove",
                "aignm", "aigor", "aigreset", "aigsim", "aigsplit",
                "aigstrip", "aigtoaig", "aigtoblif", "aigtocnf", "aigtodot",
                "aigtosmv", "aigunconstraint", "aigunroll", "aigvis", "andtoaig",
                "bliftoaig", "smvtoaig", "soltostim", "wrapstim"

    system "ar rcs libaiger.a `ls *.o`"
    lib.install "libaiger.a"
    include.install "aiger.h", "aigfuzz.h", "simpaig.h"
    (share/'aiger').install Dir["*.o"]
    File.symlink((include/'aiger.h'), (share/'aiger/aiger.h'))
    File.symlink((include/'aigfuzz.h'), (share/'aiger/aigfuzz.h'))
    File.symlink((include/'simpaig.h'), (share/'aiger/simpaig.h'))
    ohai <<-EOS.undent
    The library file (libaiger.a) and the header files have been respectively installed to
    /usr/local/lib and /usr/local/include. Since some tools from the FMV group requires
    object files, the object files along with the header files have been install to
    /usr/local/share/aiger.
    EOS
  end

end


__END__
diff --git a/aigbmc.c b/aigbmc.c
index a7c59a3..938b27b 100644
--- a/aigbmc.c
+++ b/aigbmc.c
@@ -23,7 +23,7 @@ IN THE SOFTWARE.
 #include "aiger.h"
 
 #ifdef AIGER_HAVE_PICOSAT
-#include "../picosat/picosat.h"
+#include "picosat.h"
 #endif
 
 #ifdef AIGER_HAVE_LINGELING
diff --git a/aigdep.c b/aigdep.c
index 2364886..fafbcd3 100644
--- a/aigdep.c
+++ b/aigdep.c
@@ -23,7 +23,7 @@ IN THE SOFTWARE.
 #include "aiger.h"
 
 #ifdef AIGER_HAVE_PICOSAT
-#include "../picosat/picosat.h"
+#include "picosat.h"
 static int use_picosat;
 static PicoSAT * picosat;
 #endif
diff --git a/configure.sh b/configure.sh
index 3e7de47..59abd1f 100755
--- a/configure.sh
+++ b/configure.sh
@@ -60,37 +60,37 @@ AIGBMCFLAGS="$CFLAGS"
 AIGDEPCFLAGS="$CFLAGS"
 
 PICOSAT=no
-if [ -d ../picosat ]
+if [ -d /usr/local ]
 then
-  if [ -f ../picosat/picosat.h ]
+  if [ -f /usr/local/include/picosat.h ]
   then
-    if [ -f ../picosat/picosat.o ]
+    if [ -f /usr/local/lib/libpicosat.a ]
     then
-      if [ -f ../picosat/VERSION ] 
+      if [ -f /usr/local/bin/picosat ] 
       then
-	PICOSATVERSION="`cat ../picosat/VERSION`"
+	PICOSATVERSION="`/usr/local/bin/picosat --version`"
 	if [ $PICOSATVERSION -lt 953 ]
 	then
-	  wrn "out-dated version $PICOSATVERSION in '../picosat/' (need at least 953 for 'aigbmc')"
+	  wrn "out-dated version $PICOSATVERSION in '/usr/local/bin/picosat/' (need at least 953 for 'aigbmc')"
 	else
-	  msg "found PicoSAT version $PICOSATVERSION in '../picosat'"
+	  msg "found PicoSAT version $PICOSATVERSION in '/usr/local/bin/picosat'"
 	  AIGBMCTARGET="aigbmc"
-	  msg "using '../picosat/picosat.o' for 'aigbmc' and 'aigdep'"
+	  msg "using '/usr/local/lib/libpicosat.a' for 'aigbmc' and 'aigdep'"
 	  PICOSAT=yes
-	  AIGBMCHDEPS="../picosat/picosat.h"
-	  AIGBMCODEPS="../picosat/picosat.o"
-	  AIGBMCLIBS="../picosat/picosat.o"
+	  AIGBMCHDEPS="/usr/local/include/picosat.h"
+	  AIGBMCODEPS="/usr/local/lib/libpicosat.a"
+	  AIGBMCLIBS="/usr/local/lib/libpicosat.a"
 	  AIGBMCFLAGS="$AIGBMCFLAGS -DAIGER_HAVE_PICOSAT"
 	fi
       else
-        wrn "can not find '../picosat/VERSION' (missing for 'aigbmc')"
+        wrn "can not find '/usr/local/bin/picosat' (missing for 'aigbmc')"
       fi
     else
     wrn \
-      "can not find '../picosat/picosat.o' object file (no 'aigbmc' target)"
+      "can not find '/usr/local/lib/libpicosat.a' file (no 'aigbmc' target)"
     fi
   else
-    wrn "can not find '../picosat/picosat.h' header (no 'aigbmc' target)"
+    wrn "can not find '/usr/local/include/picosat.h' header (no 'aigbmc' target)"
   fi
 else
   wrn "can not find '../picosat' directory (no 'aigbmc' target)"

