class Aiger < Formula
  desc "Format, library and set of utilities for And-Inverter Graphs"
  homepage "http://fmv.jku.at/aiger/"
  url "http://fmv.jku.at/aiger/aiger-1.9.9.tar.gz"
  sha256 "1e50d3db36f5dc5ed0e57aa4c448b9bcf82865f01736dde1f32f390b780350c7"

  resource "lingeling" do
    url "https://github.com/arminbiere/lingeling",
        using:    :git,
        revision: "72d2b13eea5fbd95557a3d0d199cd98dfbdc76ee"
    version "72d2b13"
  end

  resource "picosat" do
    url "http://fmv.jku.at/picosat/picosat-965.tar.gz"
    sha256 "15169b4f28ba8f628f353f6f75a100845cdef4a2244f101a02b6e5a26e46a754"
  end

  patch :DATA

  def install
    resource("lingeling").stage do
      system "./configure.sh"
      system "make"
    end
    resource("picosat").stage do
      system "./configure.sh"
      system "make"
    end
    system "./configure.sh"
    system "make"
    bin.install "aigand", "aigdd", "aigflip", "aigfuzz", "aiginfo",
                "aigjoin", "aigmiter", "aigmove", "aignm", "aigor",
                "aigreset", "aigsim", "aigsplit", "aigstrip", "aigtoaig",
                "aigtoblif", "aigtocnf", "aigtodot", "aigtosmv",
                "aigunconstraint", "aigunroll", "andtoaig",
                "bliftoaig", "smvtoaig", "soltostim", "wrapstim"

    system "ar rcs libaiger.a `ls *.o`"
    lib.install "libaiger.a"
    include.install "aiger.h", "aigfuzz.h", "simpaig.h"
    (share/"aiger").install Dir["*.o"]
    File.symlink((include/"aiger.h"), (share/"aiger/aiger.h"))
    File.symlink((include/"aigfuzz.h"), (share/"aiger/aigfuzz.h"))
    File.symlink((include/"simpaig.h"), (share/"aiger/simpaig.h"))
    ohai "Installation notes"
    puts <<~EOS
    The library file (libaiger.a) and the header files have been installed to
      #{lib}
    and
      #{include}
    respectively. Since some tools from the FMV group requires object files,
    the object files along with the header files have been install to
      #{share}/aiger.
    EOS
  end
end


__END__
diff --git a/configure.sh b/configure.sh
index 3e7de47..8831477 100755
--- a/configure.sh
+++ b/configure.sh
@@ -60,63 +60,63 @@ AIGBMCFLAGS="$CFLAGS"
 AIGDEPCFLAGS="$CFLAGS"
 
 PICOSAT=no
-if [ -d ../picosat ]
+if [ -d ./picosat ]
 then
-  if [ -f ../picosat/picosat.h ]
+  if [ -f ./picosat/picosat.h ]
   then
-    if [ -f ../picosat/picosat.o ]
+    if [ -f ./picosat/picosat.o ]
     then
-      if [ -f ../picosat/VERSION ] 
+      if [ -f ./picosat/VERSION ] 
       then
-	PICOSATVERSION="`cat ../picosat/VERSION`"
+	PICOSATVERSION="`cat ./picosat/VERSION`"
 	if [ $PICOSATVERSION -lt 953 ]
 	then
-	  wrn "out-dated version $PICOSATVERSION in '../picosat/' (need at least 953 for 'aigbmc')"
+	  wrn "out-dated version $PICOSATVERSION in './picosat/' (need at least 953 for 'aigbmc')"
 	else
-	  msg "found PicoSAT version $PICOSATVERSION in '../picosat'"
+	  msg "found PicoSAT version $PICOSATVERSION in './picosat'"
 	  AIGBMCTARGET="aigbmc"
-	  msg "using '../picosat/picosat.o' for 'aigbmc' and 'aigdep'"
+	  msg "using './picosat/picosat.o' for 'aigbmc' and 'aigdep'"
 	  PICOSAT=yes
-	  AIGBMCHDEPS="../picosat/picosat.h"
-	  AIGBMCODEPS="../picosat/picosat.o"
-	  AIGBMCLIBS="../picosat/picosat.o"
+	  AIGBMCHDEPS="./picosat/picosat.h"
+	  AIGBMCODEPS="./picosat/picosat.o"
+	  AIGBMCLIBS="./picosat/picosat.o"
 	  AIGBMCFLAGS="$AIGBMCFLAGS -DAIGER_HAVE_PICOSAT"
 	fi
       else
-        wrn "can not find '../picosat/VERSION' (missing for 'aigbmc')"
+        wrn "can not find './picosat/VERSION' (missing for 'aigbmc')"
       fi
     else
     wrn \
-      "can not find '../picosat/picosat.o' object file (no 'aigbmc' target)"
+      "can not find './picosat/picosat.o' object file (no 'aigbmc' target)"
     fi
   else
-    wrn "can not find '../picosat/picosat.h' header (no 'aigbmc' target)"
+    wrn "can not find './picosat/picosat.h' header (no 'aigbmc' target)"
   fi
 else
-  wrn "can not find '../picosat' directory (no 'aigbmc' target)"
+  wrn "can not find './picosat' directory (no 'aigbmc' target)"
 fi
 
 LINGELING=no
-if [ -d ../lingeling ]
+if [ -d ./lingeling ]
 then
-  if [ -f ../lingeling/lglib.h ]
+  if [ -f ./lingeling/lglib.h ]
   then
-    if [ -f ../lingeling/liblgl.a ]
+    if [ -f ./lingeling/liblgl.a ]
     then
-      msg "using '../lingeling/liblgl.a' for 'aigbmc' and 'aigdep'"
+      msg "using './lingeling/liblgl.a' for 'aigbmc' and 'aigdep'"
       LINGELING=yes
-      AIGBMCHDEPS="$AIGBMCHDEPS ../lingeling/lglib.h"
-      AIGBMCODEPS="$AIGBMCODEPS ../lingeling/liblgl.a"
-      AIGBMCLIBS="$AIGBMCLIBS -L../lingeling -llgl -lm"
+      AIGBMCHDEPS="$AIGBMCHDEPS ./lingeling/lglib.h"
+      AIGBMCODEPS="$AIGBMCODEPS ./lingeling/liblgl.a"
+      AIGBMCLIBS="$AIGBMCLIBS -L./lingeling -llgl -lm"
       AIGBMCFLAGS="$AIGBMCFLAGS -DAIGER_HAVE_LINGELING"
     else
-      wrn "can not find '../lingeling/liblgl.a' library"
+      wrn "can not find './lingeling/liblgl.a' library"
     fi
   else
-    wrn "can not find '../lingeling/lglib.h' header"
+    wrn "can not find './lingeling/lglib.h' header"
   fi
 else
-  wrn "can not find '../lingeling' directory"
+  wrn "can not find './lingeling' directory"
 fi
 
 if [ $PICOSAT = yes -o $LINGELING = yes ]
@@ -128,24 +128,24 @@ then
   AIGDEPLIBS="$AIGBMCLIBS"
   AIGDEPFLAGS="$AIGBMCFLAGS"
 else
-  wrn "no proper '../lingeling' nor '../picosat' (will not build 'aigbmc' nor 'aigdep')"
+  wrn "no proper './lingeling' nor './picosat' (will not build 'aigbmc' nor 'aigdep')"
 fi
 
 msg "compiling with: $CC $CFLAGS"
 rm -f makefile
 sed \
-  -e "s/@CC@/$CC/" \
-  -e "s/@CFLAGS@/$CFLAGS/" \
-  -e "s/@AIGBMCTARGET@/$AIGBMCTARGET/" \
-  -e "s/@AIGBMCTARGET@/$AIGBMCTARGET/" \
-  -e "s,@AIGBMCHDEPS@,$AIGBMCHDEPS," \
-  -e "s,@AIGBMCODEPS@,$AIGBMCODEPS," \
-  -e "s,@AIGBMCLIBS@,$AIGBMCLIBS," \
-  -e "s,@AIGBMCFLAGS@,$AIGBMCFLAGS," \
-  -e "s/@AIGDEPTARGET@/$AIGDEPTARGET/" \
-  -e "s/@AIGDEPTARGET@/$AIGDEPTARGET/" \
-  -e "s,@AIGDEPHDEPS@,$AIGDEPHDEPS," \
-  -e "s,@AIGDEPCODEPS@,$AIGDEPCODEPS," \
-  -e "s,@AIGDEPLIBS@,$AIGDEPLIBS," \
-  -e "s,@AIGDEPFLAGS@,$AIGDEPFLAGS," \
+  -e "s#@CC@#$CC#" \
+  -e "s#@CFLAGS@#$CFLAGS#" \
+  -e "s#@AIGBMCTARGET@#$AIGBMCTARGET#" \
+  -e "s#@AIGBMCTARGET@#$AIGBMCTARGET#" \
+  -e "s#@AIGBMCHDEPS@#$AIGBMCHDEPS#" \
+  -e "s#@AIGBMCODEPS@#$AIGBMCODEPS#" \
+  -e "s#@AIGBMCLIBS@#$AIGBMCLIBS#" \
+  -e "s#@AIGBMCFLAGS@#$AIGBMCFLAGS#" \
+  -e "s#@AIGDEPTARGET@#$AIGDEPTARGET#" \
+  -e "s#@AIGDEPTARGET@#$AIGDEPTARGET#" \
+  -e "s#@AIGDEPHDEPS@#$AIGDEPHDEPS#" \
+  -e "s#@AIGDEPCODEPS@#$AIGDEPCODEPS#" \
+  -e "s#@AIGDEPLIBS@#$AIGDEPLIBS#" \
+  -e "s#@AIGDEPFLAGS@#$AIGDEPFLAGS#" \
   makefile.in > makefile

