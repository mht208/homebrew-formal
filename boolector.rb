require 'formula'

class Boolector < Formula
  homepage 'http://fmv.jku.at/boolector/'
  url 'http://fmv.jku.at/boolector/boolector-1.4.1-376e6b0-110304.tar.gz'
  version '1.4.1'
  sha1 '073ddb819668fddd51f0893eb57a9444383c0b0f'

  depends_on 'picosat'

  def patches
    # Fix the paths to picosat.
    DATA
  end

  def install
    system "./configure"
    system "make LIBS=-lpicosat PICOSATLIB=#{HOMEBREW_PREFIX}/lib/libpicosat.a"
    bin.install 'boolector', 'deltabtor', 'synthebtor'
    (include/'boolector').install Dir['*.h']
    lib.install 'libboolector.a'
  end
end


__END__
diff --git a/btorexp.c b/btorexp.c
index 18e02b9..12a34d0 100644
--- a/btorexp.c
+++ b/btorexp.c
@@ -27,7 +27,7 @@
 #include "btorconfig.h"
 #include "btorexit.h"
 #include "btorrewrite.h"
-#include "../picosat/picosat.h"
+#include "picosat.h"
 
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/btorsat.c b/btorsat.c
index 223237b..93ef4f1 100644
--- a/btorsat.c
+++ b/btorsat.c
@@ -17,7 +17,7 @@
  *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "../picosat/picosat.h"
+#include "picosat.h"
 
 #ifdef BTOR_USE_PICOPREP
 #include "../picoprep/picoprep.h"
diff --git a/configure b/configure
index 275c250..bd20cae 100755
--- a/configure
+++ b/configure
@@ -23,9 +23,6 @@ check () {
  [ -f $1 ] || die "can not find '$1'" 
 }
 
-check ../picosat/picosat.h
-check ../picosat/version.o
-check ../picosat/picosat.o
 echo "picosat backend"
 
 if [ $precosat = yes ]
diff --git a/makefile.in b/makefile.in
index da61dcb..9049773 100644
--- a/makefile.in
+++ b/makefile.in
@@ -4,7 +4,7 @@
 .cc.o:
 	$(CC) $(CFLAGS) -c $<
 OBJ=boolector.o $(addsuffix .o,$(basename $(wildcard btor*.c))) \
-  ../picosat/picosat.o ../picosat/version.o @PRECOSAT@
+  $(PICOSATLIB) @PRECOSAT@
 CC=@CC@
 CFLAGS=@CFLAGS@
 LIBS=@LIBS@
