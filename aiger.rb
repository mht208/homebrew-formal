require 'formula'

class Aiger < Formula
  homepage 'http://fmv.jku.at/aiger/'
  url 'http://fmv.jku.at/aiger/aiger-1.9.4.tar.gz'
  sha1 '635a8d6745f12d8e7f471c61e5121f040d8443f0'

  # aiger-1.9.4 is not compatible with picosat-957
  depends_on 'picosat-951'

  def patches
    DATA
  end

  def install
    system "./configure"
    system "make"
    bin.install "aigand"
    bin.install "aigbmc"
    bin.install "aigdd"
    bin.install "aigflip"
    bin.install "aigfuzz"
    bin.install "aiginfo"
    bin.install "aigjoin"
    bin.install "aigmiter"
    bin.install "aigmove"
    bin.install "aignm"
    bin.install "aigor"
    bin.install "aigsim"
    bin.install "aigsplit"
    bin.install "aigstrip"
    bin.install "aigtoaig"
    bin.install "aigtoblif"
    bin.install "aigtocnf"
    bin.install "aigtodot"
    bin.install "aigtosmv"
    bin.install "aigunroll"
    bin.install "aigvis"
    bin.install "andtoaig"
    bin.install "bliftoaig"
    bin.install "smvtoaig"
    bin.install "soltostim"
    bin.install "wrapstim"

    system "ar rcs libaiger.a aigand.o aigbmc.o aigdd.o aiger.o aigflip.o aigfuzz.o aigfuzzlayers.o aiginfo.o aigjoin.o aigmiter.o aigmove.o aignm.o aigor.o aigsim.o aigsplit.o aigstrip.o aigtoaig.o aigtoblif.o aigtocnf.o aigtodot.o aigtosmv.o aigunroll.o andtoaig.o bliftoaig.o simpaig.o smvtoaig.o soltostim.o wrapstim.o"
    lib.install "libaiger.a"
    include.install "aiger.h", "aigfuzz.h", "simpaig.h"      
    (share/'aiger').install "aigand.o", "aigbmc.o", "aigdd.o", "aiger.o", "aigflip.o", "aigfuzz.o", "aigfuzzlayers.o", "aiginfo.o", "aigjoin.o", "aigmiter.o", "aigmove.o", "aignm.o", "aigor.o", "aigsim.o", "aigsplit.o", "aigstrip.o", "aigtoaig.o", "aigtoblif.o", "aigtocnf.o", "aigtodot.o", "aigtosmv.o", "aigunroll.o", "andtoaig.o", "bliftoaig.o", "simpaig.o", "smvtoaig.o", "soltostim.o", "wrapstim.o"
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
index 33b68cb..9f9baaf 100644
--- a/aigbmc.c
+++ b/aigbmc.c
@@ -21,7 +21,7 @@ IN THE SOFTWARE.
 ***************************************************************************/
 
 #include "aiger.h"
-#include "../picosat/picosat.h"
+#include "/usr/local/include/picosat-951/picosat.h"
 
 #include <assert.h>
 #include <ctype.h>
diff --git a/configure b/configure
index 0c36e77..08ff760 100755
--- a/configure
+++ b/configure
@@ -55,23 +55,23 @@ then
 else
   message "using custom compilation flags"
 fi
-if [ -d ../picosat ]
+if [ -d /usr/local/opt/picosat-951 ]
 then
-  if [ -f ../picosat/picosat.h ]
+  if [ -f /usr/local/include/picosat-951/picosat.h ]
   then
-    if [ -f ../picosat/picosat.o ]
+    if [ -f /usr/local/lib/picosat-951/libpicosat.a ]
     then
       AIGBMCTARGET="aigbmc"
-      message "using 'picosat.h' and 'picosat.o' in '../picosat/' for 'aigbmc'"
+      message "using 'picosat.h' and 'picosat.a' for 'aigbmc'"
     else
     warning \
-      "can not find '../picosat/picosat.o' object file (no 'aigbmc' target)"
+      "can not find '/usr/local/lib/picosat-951/libpicosat.a' object file (no 'aigbmc' target)"
     fi
   else
-    warning "can not find '../picosat/picosat.h' header (no 'aigbmc' target)"
+    warning "can not find '/usr/local/include/picosat-951/picosat.h' header (no 'aigbmc' target)"
   fi
 else
-  warning "can not find '../picosat' directory (no 'aigbmc' target)"
+  warning "can not find '/usr/local/opt/picosat-951' directory (no 'aigbmc' target)"
 fi
 message "compiling with: $CC $CFLAGS"
 rm -f makefile
diff --git a/makefile.in b/makefile.in
index 8aa0f3a..b676b63 100644
--- a/makefile.in
+++ b/makefile.in
@@ -39,8 +39,8 @@ all: $(TARGETS)
 
 aigand: aiger.o aigand.o makefile
 	$(CC) $(CFLAGS) -o $@ aigand.o aiger.o
-aigbmc: aiger.o aigbmc.o makefile ../picosat/picosat.o
-	$(CC) $(CFLAGS) -o $@ aigbmc.o aiger.o ../picosat/picosat.o
+aigbmc: aiger.o aigbmc.o makefile /usr/local/lib/picosat-951/libpicosat.a
+	$(CC) $(CFLAGS) -o $@ aigbmc.o aiger.o /usr/local/lib/picosat-951/libpicosat.a
 aigdd: aiger.o aigdd.o makefile
 	$(CC) $(CFLAGS) -o $@ aigdd.o aiger.o
 aigflip: aiger.o aigflip.o makefile
@@ -89,7 +89,7 @@ wrapstim: aiger.o wrapstim.o makefile
 	$(CC) $(CFLAGS) -o $@ wrapstim.o aiger.o
 
 aigand.o: aiger.h aigand.c makefile
-aigbmc.o: aiger.h aigbmc.c makefile ../picosat/picosat.h
+aigbmc.o: aiger.h aigbmc.c makefile /usr/local/include/picosat-951/picosat.h
 aigdd.o: aiger.h aigdd.c makefile
 aiger.o: aiger.h aiger.c makefile
 aigflip.o: aiger.h aigflip.c makefile

