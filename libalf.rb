require 'formula'

class Libalf < Formula
  homepage 'http://libalf.informatik.rwth-aachen.de/index.php'
  url 'http://libalf.informatik.rwth-aachen.de/files/libalf-v0.3.tar.bz2'
  sha256 'd26bf6b0e9cd3900db00a2ef2c0a669bf87de67293d4ededc292aeccfe6632f7'

  depends_on 'gcc'

  patch :DATA

  fails_with :clang do
    build 1001
    cause "../include/libalf/knowledgebase.h:90:40: error: no class named 'iterator' in 'knowledgebase<answer>'"
  end

  fails_with :clang do
    build 900
    cause "../include/libalf/knowledgebase.h:90:40: error: no class named 'iterator' in 'knowledgebase<answer>'"
  end

  def install
    Dir.chdir 'libalf' do
      system "make"
      system "LIBDIR=#{lib} INCLUDEDIR=#{include} make install"
    end
  end
end

__END__
diff --git a/libalf/include/libalf/minisat_Solver.h b/libalf/include/libalf/minisat_Solver.h
index 82aa192..8e47dd0 100644
--- a/libalf/include/libalf/minisat_Solver.h
+++ b/libalf/include/libalf/minisat_Solver.h
@@ -28,6 +28,8 @@ OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWA
 #ifndef Solver_h
 #define Solver_h
 
+#define uint unsigned int
+
 #include "libalf/minisat_SolverTypes.h"
 #include "libalf/minisat_VarOrder.h"
 
diff --git a/libalf/src/Makefile b/libalf/src/Makefile
index eef5f47..8f35eda 100644
--- a/libalf/src/Makefile
+++ b/libalf/src/Makefile
@@ -32,15 +32,15 @@ ifeq (${OS}, Windows_NT)
   LDFLAGS += -lws2_32
   TARGET=libalf.dll
 else
-  TARGET=libalf.so
+  TARGET=libalf.dylib
 endif
 
-INSTALL_SHARED_NAME=${TARGET}${LIBVERSIONTAG}
+INSTALL_SHARED_NAME=libalf${LIBVERSIONTAG}.dylib
 INSTALL_STATIC_NAME=libalf.a${LIBVERSIONTAG}
 
 all:	${TARGET}
 
-libalf.so: ${OBJECTS}
+libalf.dylib: ${OBJECTS}
 	${CXX} $(OBJECTS) $(LDFLAGS) -o $@ 
 
 libalf.dll: ${OBJECTS}
@@ -57,8 +57,8 @@ install: ${TARGET} libalf.a
 	@echo installing libalf library to ${LIBDIR} ...
 	@echo
 	-install -v -m 755 -d ${LIBDIR}
-	install -T -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
-	install -T -v -m 755 libalf.a  ${LIBDIR}/${INSTALL_STATIC_NAME}
+	install -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
+	install -v -m 755 libalf.a  ${LIBDIR}/${INSTALL_STATIC_NAME}
 	# symlinks
 	-rm -f ${LIBDIR}/${TARGET}
 	ln -s ${LIBDIR}/${INSTALL_SHARED_NAME} ${LIBDIR}/${TARGET}

