require 'formula'

class Libmvca < Formula
  homepage 'http://libalf.informatik.rwth-aachen.de/index.php'
  url 'http://libalf.informatik.rwth-aachen.de/files/libmVCA-v0.3.tar.bz2'
  sha256 'e5540f9efaf571bf568e71bfda851bc798d8e179e2e31d8398bda41002ad62d9'

  patch :DATA

  def install
    system "make"
    system "LIBDIR=#{lib} INCLUDEDIR=#{include} make install"
  end
end

__END__
diff --git a/src/Makefile b/src/Makefile
index 5aa5179..88af37c 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -22,10 +22,10 @@ endif
 ifeq (${OS}, Windows_NT)
   TARGET=mVCA.dll
 else
-  TARGET=libmVCA.so
+  TARGET=libmVCA.dylib
 endif
 
-INSTALL_SHARED_NAME=${TARGET}${LIBVERSIONTAG}
+INSTALL_SHARED_NAME=libmVCA${LIBVERSIONTAG}.dylib
 INSTALL_STATIC_NAME=libmVCA.a${LIBVERSIONTAG}
 
 
@@ -42,7 +42,7 @@ OBJECTS=pushdown.o transition_function.o mVCA.o deterministic_mVCA.o nondetermin
 
 all:	${TARGET}
 
-libmVCA.so: ${OBJECTS}
+libmVCA.dylib: ${OBJECTS}
 	${CXX} $(OBJECTS) $(LDFLAGS) -o $@ 
 
 mVCA.dll: ${OBJECTS}
@@ -59,8 +59,8 @@ install: ${TARGET} libmVCA.a
 	@echo installing libmVCA library to ${LIBDIR} ...
 	@echo
 	-install -v -m 755 -d ${LIBDIR}
-	install -T -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
-	install -T -v -m 755 libmVCA.a  ${LIBDIR}/${INSTALL_STATIC_NAME}
+	install -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
+	install -v -m 755 libmVCA.a  ${LIBDIR}/${INSTALL_STATIC_NAME}
 	# symlinks
 	-rm -f ${LIBDIR}/${TARGET}
 	ln -s ${LIBDIR}/${INSTALL_SHARED_NAME} ${LIBDIR}/${TARGET}

