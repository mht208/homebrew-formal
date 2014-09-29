require 'formula'

class Princess < Formula
  homepage 'http://www.philipp.ruemmer.org/princess.shtml'
  url 'http://www.philipp.ruemmer.org/princess/princess-2014-08-27.tar.gz'
  sha1 '2a2533b9da3775a7762ad5340ca6982f60c09e96'

  depends_on 'scala'

  patch :DATA

  def install
    system "curl", "http://www2.cs.tum.edu/projects/cup/java-cup-11a.jar", "-o", "extlibs/java-cup-11a.jar"
    system "make"

    bins = ["princessBench", "princess", "princessGui", "werePrincess"]
    (share/"princess").install bins
    bin.mkdir
    bins.each do |file|
      ln_s share+"princess"+file, bin+file
    end
    (share/"princess").install "bin"
    (share/"princess"/"parser").install "parser/parser.jar"
    (share/"princess"/"smt-parser").install "smt-parser/smt-parser.jar"
    (share/"princess").install "extlibs"
    (share/"princess").install "wolverine_resources"
  end
end

__END__
diff --git a/princess b/princess
index 134b22a..a9a2f29 100755
--- a/princess
+++ b/princess
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-BASEDIR=`dirname $(readlink -e $0)`
+BASEDIR=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $BASEDIR)`
 EXTLIBSDIR=$BASEDIR/extlibs
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/bin:$BASEDIR/smt-parser/smt-parser.jar:$BASEDIR/parser/parser.jar:$EXTLIBSDIR/java-cup-11a.jar
diff --git a/princessBench b/princessBench
index 0a906b9..ded9155 100755
--- a/princessBench
+++ b/princessBench
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-BASEDIR=`dirname $0`
+BASEDIR=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $BASEDIR)`
 EXTLIBSDIR=$BASEDIR/extlibs
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/bin:$BASEDIR/parser/parser.jar:$EXTLIBSDIR/java-cup-11a.jar
diff --git a/princessGui b/princessGui
index 969ba9b..f086ebd 100755
--- a/princessGui
+++ b/princessGui
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-BASEDIR=`dirname $(readlink -e $0)`
+BASEDIR=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $BASEDIR)`
 EXTLIBSDIR=$BASEDIR/extlibs
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/bin:$BASEDIR/parser/parser.jar:$BASEDIR/smt-parser/smt-parser.jar:$EXTLIBSDIR/java-cup-11a.jar
diff --git a/runTests b/runTests
index 18fb9c6..3878627 100755
--- a/runTests
+++ b/runTests
@@ -2,7 +2,8 @@
 
 echo -n "Running unit tests "
 
-BASEDIR=`dirname $0`
+BASEDIR=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $BASEDIR)`
 EXTLIBSDIR=$BASEDIR/extlibs
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/bin:$BASEDIR/parser/parser.jar:$EXTLIBSDIR/java-cup-11a.jar
@@ -13,4 +14,4 @@ scala ap.AllTests "$@"
 echo "Running regression tests"
 
 cd $BASEDIR/testcases
-./runalldirs
\ No newline at end of file
+./runalldirs
diff --git a/werePrincess b/werePrincess
index 1d3ccf0..4b6e906 100755
--- a/werePrincess
+++ b/werePrincess
@@ -1,14 +1,7 @@
 #!/bin/sh
 
-if [ $(uname) = "Linux" ]; then
-    pathCmd="readlink -f"
-elif [ $(uname) = "Darwin" ]; then
-    pathCmd="stat -f %N"
-else
-    pathCmd="realpath"
-fi
-
-BASEDIR=`dirname $($pathCmd $0)`
+BASEDIR=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $BASEDIR)`
 EXTLIBSDIR=$BASEDIR/extlibs
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/bin:$BASEDIR/parser/parser.jar:$EXTLIBSDIR/java-cup-11a.jar

