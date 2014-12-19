require 'formula'

class Libamore < Formula
  homepage 'http://libalf.informatik.rwth-aachen.de/index.php'
  url 'http://libalf.informatik.rwth-aachen.de/files/libAMoRE(++)-v0.3.tar.bz2'
  sha1 '38f36e23040ecf23b7723b36da329ea09461625f'

  patch :DATA

  def install
    Dir.chdir 'libAMoRE' do
      system "make"
      system "LIBDIR=#{lib} INCLUDEDIR=#{include} make install"
    end
    Dir.chdir 'libAMoRE++' do
      system "make"
      system "LIBDIR=#{lib} INCLUDEDIR=#{include} make install"
    end
  end
end

__END__
diff --git a/libAMoRE/Makefile b/libAMoRE/Makefile
index 48e1886..585bbb5 100644
--- a/libAMoRE/Makefile
+++ b/libAMoRE/Makefile
@@ -23,14 +23,14 @@ ifeq (${OS}, Windows_NT)
   LDFLAGS += -lws2_32
   TARGET=AMoRE.dll
 else
-  TARGET=libAMoRE.so
+  TARGET=libAMoRE.dylib
   CFLAGS += -DUNIX -DLINUX
 endif
 
-INSTALL_SHARED_NAME=${TARGET}${LIBVERSIONTAG}
+INSTALL_SHARED_NAME=libAMoRE${LIBVERSIONTAG}.dylib
 INSTALL_STATIC_NAME=libAMoRE.a${LIBVERSIONTAG}
 
-CFLAGS += -DDEBUG -DJAVAEXCEPT -DLIBAMORE -DBIT32
+CFLAGS += -DDEBUG -DJAVAEXCEPT -DLIBAMORE -DBIT32 -I/usr/include/malloc
 CFLAGS += -DVERSION="\"${VERSION}\""
 CFLAGS += -Wall -Iinclude -fpic
 CFLAGS += -fno-stack-protector
@@ -58,20 +58,20 @@ OBJ = global.o buffer.o liberror.o parse.o fileIO.o \
 
 all: libAMoRE.a ${TARGET}
 
-libtest: libtest.c libAMoRE.so
+libtest: libtest.c libAMoRE.dylib
 	${CC} ${CFLAGS} -o $@ $< -g -L. -lAMoRE
 
 libAMoRE.a: $(OBJ)
 	${AR} crs $@ $?
 
-libAMoRE.so: $(OBJ)
+libAMoRE.dylib: $(OBJ)
 	${CC} ${LDFLAGS} -o $@ $?
 
 AMoRE.dll: $(OBJ)
 	${CC} ${LDFLAGS} -o $@ $?
 	
 clean:
-	-rm -f *~ */*~ $(OBJ) libAMoRE.a libAMoRE.so AMoRE.dll libtest
+	-rm -f *~ */*~ $(OBJ) libAMoRE.a libAMoRE.dylib AMoRE.dll libtest
 	-rm -Rf docs/html docs/latex 
 
 doc:
@@ -83,8 +83,8 @@ install: installHeaders all
 	@echo installing libAMoRE library to ${INCLUDEDIR} ...
 	@echo
 	-install -v -m 755 -d ${LIBDIR}
-	install -T -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
-	install -T -v -m 755 libAMoRE.a ${LIBDIR}/${INSTALL_STATIC_NAME}
+	install -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
+	install -v -m 755 libAMoRE.a ${LIBDIR}/${INSTALL_STATIC_NAME}
 	# symlinks
 	-rm -f ${LIBDIR}/${TARGET}
 	ln -s ${LIBDIR}/${INSTALL_SHARED_NAME} ${LIBDIR}/${TARGET}
diff --git a/libAMoRE/include/amore/ext.h b/libAMoRE/include/amore/ext.h
index a5e8b16..ce9eb01 100644
--- a/libAMoRE/include/amore/ext.h
+++ b/libAMoRE/include/amore/ext.h
@@ -42,9 +42,9 @@
 #include <amore/cons.h>
 #include <amore/typedefs.h>
 
-#ifdef UNIX
-# include <amore/unix.h>
-#endif
+//#ifdef UNIX
+//# include <amore/unix.h>
+//#endif
 
 #ifdef __cplusplus
 extern "C" {
diff --git a/libAMoRE/ldo/rexFromString.c b/libAMoRE/ldo/rexFromString.c
index 3bd38d1..2236c49 100644
--- a/libAMoRE/ldo/rexFromString.c
+++ b/libAMoRE/ldo/rexFromString.c
@@ -18,7 +18,7 @@
  */
 
 #include <amore/rexFromString.h>
-#include <error.h>
+//#include <error.h>
 
 #include <amore/parse.h>
 
diff --git a/libAMoRE++/src/Makefile b/libAMoRE++/src/Makefile
index 6be0946..6424730 100644
--- a/libAMoRE++/src/Makefile
+++ b/libAMoRE++/src/Makefile
@@ -23,26 +23,26 @@ ifeq (${OS}, Windows_NT)
   LDFLAGS += -lws2_32
   TARGET=AMoRE++.dll
 else
-  TARGET=libAMoRE++.so
+  TARGET=libAMoRE++.dylib
 endif
 
-INSTALL_SHARED_NAME=$(TARGET)${LIBVERSIONTAG}
+INSTALL_SHARED_NAME=libAMoRE++${LIBVERSIONTAG}.dylib
 INSTALL_STATIC_NAME=libAMoRE++.a${LIBVERSIONTAG}
 
-CPPFLAGS+=-Wall -I../include/ -I${INCLUDEDIR} -shared -fpic
+CPPFLAGS+=-Wall -I../include/ -I/usr/include/malloc -I../../libAMoRE/include -I${INCLUDEDIR} -shared -fpic
 CPPFLAGS+=-Wextra
 CPPFLAGS+=-D__cplusplus -DVERSION="\"${VERSION}\""
 # for ubuntu, try disabling stack-smashing due to linker failures:
 CPPFLAGS+=-fno-stack-protector
 #CPPFLAGS+=-DANTICHAIN_DEBUG
-LDFLAGS+=-shared -L${LIBDIR} -lAMoRE
+LDFLAGS+=-shared -L${LIBDIR} -L../../libAMoRE -lAMoRE
 
 
 OBJECTS=amore.o finite_automaton.o nondeterministic_finite_automaton.o deterministic_finite_automaton.o
 
 all:	${TARGET}
 
-libAMoRE++.so: ${OBJECTS}
+libAMoRE++.dylib: ${OBJECTS}
 	${CXX} $(OBJECTS) $(LDFLAGS) -o $@
 
 AMoRE++.dll: ${OBJECTS}
@@ -52,15 +52,15 @@ libAMoRE++.a: ${OBJECTS}
 	${AR} crs $@ $?
 
 clean:
-	-rm -f *.o AMoRE.dll libAMoRE++.so libAMoRE++.a
+	-rm -f *.o AMoRE.dll libAMoRE++.dylib libAMoRE++.a
 
 install: ${TARGET} libAMoRE++.a
 	@echo
 	@echo installing ${TARGET} to ${LIBDIR} ...
 	@echo
 	-install -v -m 755 -d ${LIBDIR}
-	install -T -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
-	install -T -v -m 755 libAMoRE++.a  ${LIBDIR}/${INSTALL_STATIC_NAME}
+	install -v -m 755 ${TARGET} ${LIBDIR}/${INSTALL_SHARED_NAME}
+	install -v -m 755 libAMoRE++.a  ${LIBDIR}/${INSTALL_STATIC_NAME}
 	# symlinks
 	-rm -f ${LIBDIR}/${TARGET}
 	ln -s ${LIBDIR}/${INSTALL_SHARED_NAME} ${LIBDIR}/${TARGET}
diff --git a/libAMoRE++/src/nondeterministic_finite_automaton.cpp b/libAMoRE++/src/nondeterministic_finite_automaton.cpp
index 4b15bdc..4f4395a 100644
--- a/libAMoRE++/src/nondeterministic_finite_automaton.cpp
+++ b/libAMoRE++/src/nondeterministic_finite_automaton.cpp
@@ -764,7 +764,7 @@ std::basic_string<int32_t> nondeterministic_finite_automaton::serialize() const
 	ret += 0;
 
 	// is not deterministic
-	ret += htonl(0);
+	ret += (int32_t)htonl(0);
 	// alphabet size
 	ret += htonl(nfa_p->alphabet_size);
 	// state count

