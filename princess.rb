require 'formula'

class Princess < Formula
  homepage 'http://www.philipp.ruemmer.org/princess.shtml'
  url 'http://www.philipp.ruemmer.org/princess/princess-2013-04-21.tar.gz'
  sha1 'fe4180fe5fa332fbc213e11ccf414e6367527867'

  depends_on 'scala'

  def patches
    DATA
  end

  def install
    system "curl", "http://www2.cs.tum.edu/projects/cup/java-cup-11a.jar", "-o", "extlibs/java-cup-11a.jar"
    system "make"
    bins0 = ["princessBench"]
    bins1 = ["princess", "princessDist", "princessGui", "princessGuiDist"]
    bins2 = ["werePrincess", "werePrincessDist"]
    bins = [].concat(bins0).concat(bins1).concat(bins2)

    (share/"princess").install bins
    bin.mkdir
    bins.each do |file|
      ln_s share+"princess"+file, bin+file
    end
    (share/"princess").install "bin"
    (share/"princess"/"parser").install "parser/parser.jar"
    (share/"princess"/"smt-parser").install "smt-parser/smt-parser.jar"
    (share/"princess").install "extlibs"
  end
end

__END__
diff --git a/princess b/princess
index 2ab1109..14ecc9d 100755
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
index 0a906b9..a3c4a32 100755
--- a/princessBench
+++ b/princessBench
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-BASEDIR=`dirname $0`
+BASEDIR=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $BASEDIR)`
 EXTLIBSDIR=$BASEDIR/extlibs
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/bin:$BASEDIR/parser/parser.jar:$EXTLIBSDIR/java-cup-11a.jar
diff --git a/princessDist b/princessDist
index 410dfff..cea2b9e 100755
--- a/princessDist
+++ b/princessDist
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-BASEDIR=`dirname $(readlink -e $0)`
+BASEDIR=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $BASEDIR)`
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/dist/princess-all.jar
 
diff --git a/princessGui b/princessGui
index c83344e..dc2c148 100755
--- a/princessGui
+++ b/princessGui
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-BASEDIR=`dirname $(readlink -e $0)`
+BASEDIR=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $BASEDIR)`
 EXTLIBSDIR=$BASEDIR/extlibs
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/bin:$BASEDIR/parser/parser.jar:$BASEDIR/smt-parser/smt-parser.jar:$EXTLIBSDIR/java-cup-11a.jar
diff --git a/princessGuiDist b/princessGuiDist
index 1644f47..25480b9 100755
--- a/princessGuiDist
+++ b/princessGuiDist
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-BASEDIR=`dirname $(readlink -e $0)`
+BASEDIR=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $BASEDIR)`
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/dist/princess-all.jar
 
diff --git a/werePrincess b/werePrincess
index 968ece2..1f2ef75 100755
--- a/werePrincess
+++ b/werePrincess
@@ -1,7 +1,7 @@
 #!/bin/sh
 
-ABSEXECUTABLE=`readlink -m $0`
-BASEDIR=`dirname $ABSEXECUTABLE`
+ABSEXECUTABLE=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $ABSEXECUTABLE)`
 EXTLIBSDIR=$BASEDIR/extlibs
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/bin:$BASEDIR/parser/parser.jar:$EXTLIBSDIR/java-cup-11a.jar
diff --git a/werePrincessDist b/werePrincessDist
index 82385c5..ece86b8 100755
--- a/werePrincessDist
+++ b/werePrincessDist
@@ -1,7 +1,7 @@
 #!/bin/sh
 
-ABSEXECUTABLE=`readlink -m $0`
-BASEDIR=`dirname $ABSEXECUTABLE`
+ABSEXECUTABLE=`dirname $0`/`readlink $0`
+BASEDIR=`dirname $(readlink $ABSEXECUTABLE)`
 
 export CLASSPATH=$CLASSPATH:$BASEDIR/dist/princess-all.jar
 

