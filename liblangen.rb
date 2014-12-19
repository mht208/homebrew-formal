require 'formula'

class Liblangen < Formula
  homepage 'http://libalf.informatik.rwth-aachen.de/index.php'
  url 'http://libalf.informatik.rwth-aachen.de/files/liblangen-v0.3.tar.bz2'
  sha1 'edec5006523c4e7aa54e37c930e98d95f274ee04'

  patch :DATA

  def install
    system "make"
    system "LIBDIR=#{lib} INCLUDEDIR=#{include} make install"
  end
end

__END__
diff --git a/src/Makefile b/src/Makefile
index 6d1f42e..8250c2b 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -22,10 +22,10 @@ endif
 ifeq (${OS}, Windows_NT)
   TARGET=langen.dll
 else
-  TARGET=liblangen.so
+  TARGET=liblangen.dylib
 endif
 
-INSTALL_SHARED_NAME=${TARGET}${LIBVERSIONTAG}
+INSTALL_SHARED_NAME=liblangen${LIBVERSIONTAG}.dylib
 INSTALL_STATIC_NAME=liblangen.a${LIBVERSIONTAG}
 
 CPPFLAGS+=-Wall -I../include/ -I${INCLUDEDIR} -shared -fpic
@@ -39,7 +39,7 @@ OBJECTS=dfa_enumerator.o dfa_randomgenerator.o nfa_randomgenerator.o prng.o rege
 
 all:	${TARGET} liblangen.a
 
-liblangen.so: ${OBJECTS}
+liblangen.dylib: ${OBJECTS}
 	${CXX} $(OBJECTS) $(LDFLAGS) -o $@
 
 langen.dll: ${OBJECTS}
@@ -56,8 +56,8 @@ install: ${TARGET} liblangen.a
 	@echo installing liblangen library to ${LIBDIR} ...
 	@echo
 	-install -v -m 755 -d ${LIBDIR}
-	install -T -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
-	install -T -v -m 755 liblangen.a  ${LIBDIR}/${INSTALL_STATIC_NAME}
+	install -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
+	install -v -m 755 liblangen.a  ${LIBDIR}/${INSTALL_STATIC_NAME}
 	# symlinks
 	-rm -f ${LIBDIR}/${TARGET}
 	ln -s ${LIBDIR}/${INSTALL_SHARED_NAME} ${LIBDIR}/${TARGET}

