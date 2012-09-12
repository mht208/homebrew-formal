require 'formula'

class Cudd < Formula
  homepage 'http://vlsi.colorado.edu/~fabio/CUDD/'
  url 'ftp://vlsi.colorado.edu/pub/cudd-2.5.0.tar.gz'
  sha1 '7d0d8b4b03f5c1819fe77a82f3b947421a72d629'

  def patches
    # Adjust the compile options for Mac OS.
    DATA
  end

  def install
    system "make"
    (lib/'cudd').install "cudd/libcudd.a", "dddmp/libdddmp.a", "epd/libepd.a",
                         "mtr/libmtr.a", "st/libst.a", "util/libutil.a"
    (include/'cudd').install "cudd/cudd.h", "cudd/cuddInt.h", "obj/cuddObj.hh",
                             "dddmp/dddmp.h", "epd/epd.h",
                             "mnemosyne/mnemosyne.h", "mtr/mtr.h", "st/st.h",
                             "util/util.h"
  end

end


__END__
diff --git a/Makefile b/Makefile
index e38ffa6..42f99d1 100644
--- a/Makefile
+++ b/Makefile
@@ -59,7 +59,7 @@ ICFLAGS	= -g -O3
 #  Linux
 #
 # Gcc 4.2.4 or higher on i686.
-XCFLAGS	= -mtune=native -malign-double -DHAVE_IEEE_754 -DBSD
+XCFLAGS	= -DHAVE_IEEE_754
 # Gcc 3.2.2 or higher on i686.
 #XCFLAGS	= -mtune=pentium4 -malign-double -DHAVE_IEEE_754 -DBSD
 # Gcc 2.8.1 on i686.

