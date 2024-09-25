require 'formula'

class Princess < Formula
  homepage 'http://www.philipp.ruemmer.org/princess.shtml'
  url 'https://github.com/uuverifiers/princess/archive/refs/tags/snapshot-2022-11-03.tar.gz'
  sha256 '46ae2204f7d81b2954e8678400213d6474bb7bb793a2f7e27059424f1426ac22'
  version '2022-11-03'

  depends_on 'scala'
  depends_on 'sbt'

  patch :DATA

  def install
    system "sbt assembly"

    bins = ["princess", "princessClient", "princessGui"]
    (share/"princess").install bins
    bin.mkdir
    bins.each do |file|
      ln_s share+"princess"+file, bin+file
    end
    (share/"princess"/"parser").install "parser/parser.jar"
    (share/"princess"/"smt-parser").install "smt-parser/smt-parser.jar"
    (share/"princess").install "extlibs"
    (share/"princess").install "wolverine_resources"
    jars = Dir["target/scala-*/Princess-assembly-*.jar"]
    jars.each do |jar|
      p = jar.sub(/\/Princess-assembly.+.jar/, "")
      (share/"princess"/p).install jar
    end
  end
end

__END__
diff --git a/princess b/princess
index b9ddc9c..072bca6 100755
--- a/princess
+++ b/princess
@@ -1,14 +1,6 @@
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
+BASEDIR=`whereis -q $0 | xargs stat -f %R | xargs dirname`
 EXTLIBSDIR=$BASEDIR/extlibs
 ASSEMBLY=$BASEDIR/target/scala-2.*/Princess-assembly*
 
diff --git a/princessClient b/princessClient
index f6e5d51..9411bfd 100755
--- a/princessClient
+++ b/princessClient
@@ -29,7 +29,7 @@ startDaemon() {
     if [ ! -f "$portfile" ]; then
         touch "$lockfile"
 
-        BASEDIR=`dirname $($pathCmd $0)`
+        BASEDIR=`whereis -q $0 | xargs stat -f %R | xargs dirname`
         EXTLIBSDIR=$BASEDIR/extlibs
         ASSEMBLY=$BASEDIR/target/scala-2.*/Princess-assembly*
 
diff --git a/princessGui b/princessGui
index 74d70f7..8b886c3 100755
--- a/princessGui
+++ b/princessGui
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-BASEDIR=`dirname $(readlink -e $0)`
+BASEDIR=`whereis -q $0 | xargs stat -f %R | xargs dirname`
 EXTLIBSDIR=$BASEDIR/extlibs
 ASSEMBLY=$BASEDIR/target/scala-2.*/Princess-assembly*
 
