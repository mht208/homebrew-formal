require 'formula'

class Cvc3 < Formula
  homepage 'http://www.cs.nyu.edu/acsys/cvc3/'
  url 'http://www.cs.nyu.edu/acsys/cvc3/releases/2.4.1/cvc3-2.4.1.tar.gz'
  sha256 'd55b1d6006cfbac3f6d4c086964558902c3ed0efa66ac499cfb2193f3ee4acf7'

  option 'with-zchaff', 'Build with zChaff'
  option 'with-gmp', 'Build with GMP'
  option 'with-static', 'Build static linked binaries'
  option 'with-debug', 'Build debug version'
  option 'with-java', 'Build with Java support'

  #depends_on :flex
  #depends_on :bison
  #depends_on :python
  depends_on 'gmp' if build.include? 'with-gmp'

  patch :DATA

  fails_with :llvm do
  end

  fails_with :clang do
  end

  def install
    if build.include? 'with-static' and build.include? 'with-java'
      fail 'The Java interface requires a dynamic library build.'
    end

    args = ["--prefix=#{prefix}"]
    args << ((build.include? 'with-zchaff') ? '--enable-zchaff' : '--disable-zchaff')
    args << ((build.include? 'with-gmp') ? '--with-arith=gmp' : '--with-arith=native')
    args << ((build.include? 'with-static') ? '--enable-static' : '--enable-dynamic')
    args << ((build.include? 'with-debug') ? '--with-build=debug' : '--with-build=optimized')
    if build.include? 'with-java'
      args << '--enable-java' << '--with-java-home=/System/Library/Frameworks/JavaVM.framework/Home' << '--with-java-includes=/System/Library/Frameworks/JavaVM.framework/Headers'
    else
      args << '--disable-java'
    end
    system "./configure", *args
    system "make install" # if this fails, try separate make/make install steps
  end
end

__END__
diff --git a/src/util/rational-native.cpp b/src/util/rational-native.cpp
index 082132b..aa0bae7 100644
--- a/src/util/rational-native.cpp
+++ b/src/util/rational-native.cpp
@@ -27,6 +27,7 @@
 // For atol() (ASCII to long)
 #include <stdlib.h>
 #include <limits.h>
+#include <limits>
 #include <errno.h>
 #include <sstream>
 #include <math.h>

