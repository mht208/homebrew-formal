require 'formula'

class Reduce < Formula
  homepage 'http://www.reduce-algebra.com'
  url 'https://downloads.sourceforge.net/project/reduce-algebra/reduce-src-20110414.tar.bz2'
  sha1 'a6c73f5fcaa3efeb1cb9650bb6478d912e3914a1'

  depends_on 'clisp'
  depends_on 'freetype'
  depends_on :x11

  patch :DATA

  def install
    system "./configure --with-csl"
    system "make"
    (share/'reduce').install "README", "bin", "config.guess", "contrib",
                             "cslbuild", "doc", "generic", "packages",
                             "scripts"
    bin.install_symlink "#{share}/reduce/bin/reduce"
    ohai "The reduce package is installed in #{HOMEBREW_PREFIX}/share/reduce."
    ohai "The binary reduce is installed in #{HOMEBREW_PREFIX}/bin."
  end
end

__END__
diff --git a/csl/cslbase/Makefile.in b/csl/cslbase/Makefile.in
index 87851ab..9614012 100644
--- a/csl/cslbase/Makefile.in
+++ b/csl/cslbase/Makefile.in
@@ -2452,9 +2452,9 @@ reduce.$(fontsdir)/$(samplefont):	$(srcdir)/fonts
 @mac_framework_TRUE@make-clickable:	csl bootstrapreduce reduce
 # Rez is now an rather old fashioned way of doing things. With wxWidgets I
 # will replace this with stuff that creates application bundles.
-@mac_framework_TRUE@	/Developer/Tools/Rez -t APPL -o csl $(srcdir)/mac.r
-@mac_framework_TRUE@	/Developer/Tools/Rez -t APPL -o bootstrapreduce $(srcdir)/mac.r
-@mac_framework_TRUE@	/Developer/Tools/Rez -t APPL -o reduce $(srcdir)/mac.r
+@mac_framework_TRUE@	/usr/bin/Rez -t APPL -o csl $(srcdir)/mac.r
+@mac_framework_TRUE@	/usr/bin/Rez -t APPL -o bootstrapreduce $(srcdir)/mac.r
+@mac_framework_TRUE@	/usr/bin/Rez -t APPL -o reduce $(srcdir)/mac.r
 
 # on cygwin I scan to verify which DLLs are referenced by my main
 # executables so that I can verify (eg) that they do not link to
diff --git a/csl/fox/src/Makefile.in b/csl/fox/src/Makefile.in
index 52603c0..36ad21c 100644
--- a/csl/fox/src/Makefile.in
+++ b/csl/fox/src/Makefile.in
@@ -213,12 +213,12 @@ AUTOMAKE = @AUTOMAKE@
 AWK = @AWK@
 CC = @CC@
 CCDEPMODE = @CCDEPMODE@
-CFLAGS = @CFLAGS@
+CFLAGS = @CFLAGS@ -I/usr/local/include/freetype2
 CPP = @CPP@
-CPPFLAGS = @CPPFLAGS@
+CPPFLAGS = @CPPFLAGS@ -I/usr/local/include/freetype2
 CXX = @CXX@
 CXXDEPMODE = @CXXDEPMODE@
-CXXFLAGS = @CXXFLAGS@
+CXXFLAGS = @CXXFLAGS@ -I/usr/local/include/freetype2
 CYGPATH_W = @CYGPATH_W@
 DEFS = @DEFS@
 DEPDIR = @DEPDIR@

diff --git a/bin/bootstrapreduce b/bin/bootstrapreduce
index 8e4a324..7643baa 100755
--- a/bin/bootstrapreduce
+++ b/bin/bootstrapreduce
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/bootstrapreduce-s b/bin/bootstrapreduce-s
index 8e4a324..7643baa 100755
--- a/bin/bootstrapreduce-s
+++ b/bin/bootstrapreduce-s
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/csl b/bin/csl
index 3befa97..e67077c 100755
--- a/bin/csl
+++ b/bin/csl
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/csl-s b/bin/csl-s
index 3befa97..e67077c 100755
--- a/bin/csl-s
+++ b/bin/csl-s
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/fontdemo b/bin/fontdemo
index df0b30b..152fcf1 100755
--- a/bin/fontdemo
+++ b/bin/fontdemo
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/fontdemo-s b/bin/fontdemo-s
index df0b30b..152fcf1 100755
--- a/bin/fontdemo-s
+++ b/bin/fontdemo-s
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/fwindemo b/bin/fwindemo
index f10c1dc..8bbe6a3 100755
--- a/bin/fwindemo
+++ b/bin/fwindemo
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/fwindemo-s b/bin/fwindemo-s
index f10c1dc..8bbe6a3 100755
--- a/bin/fwindemo-s
+++ b/bin/fwindemo-s
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/redcsl b/bin/redcsl
index 6fa7f0a..51f942b 100755
--- a/bin/redcsl
+++ b/bin/redcsl
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/redcsl-s b/bin/redcsl-s
index 6fa7f0a..51f942b 100755
--- a/bin/redcsl-s
+++ b/bin/redcsl-s
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/redpslw b/bin/redpslw
index 1757d5f..d952991 100644
--- a/bin/redpslw
+++ b/bin/redpslw
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/redpslw-s b/bin/redpslw-s
index 1757d5f..d952991 100644
--- a/bin/redpslw-s
+++ b/bin/redpslw-s
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/reduce b/bin/reduce
index 5415a5f..111769d 100755
--- a/bin/reduce
+++ b/bin/reduce
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/reduce-s b/bin/reduce-s
index 5415a5f..111769d 100755
--- a/bin/reduce-s
+++ b/bin/reduce-s
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/showmathdemo b/bin/showmathdemo
index 0787eb4..6f478b9 100755
--- a/bin/showmathdemo
+++ b/bin/showmathdemo
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else
diff --git a/bin/showmathdemo-s b/bin/showmathdemo-s
index 0787eb4..6f478b9 100755
--- a/bin/showmathdemo-s
+++ b/bin/showmathdemo-s
@@ -29,7 +29,7 @@ case $a in
   ;;
 esac
 while test -h "$c"; do
-  lt=`ls -l "$c" | sed 's/.*->[ ]\+//'`
+  lt=`ls -l "$c" | sed 's/.*->[ ]*//'`
   if echo "$lt" | grep -q '^/'; then
     c="$lt"
   else

