require 'formula'

class Lingeling < Formula
  desc 'a SAT solver'
  homepage 'http://fmv.jku.at/lingeling/'
  url 'http://fmv.jku.at/lingeling/lingeling-bcj-78ebb86-180517.tar.gz'
  sha256 '2480197e48907eaaf935e96f9837366942054f26ed4c58f92ec66efedada07f2'

  option 'with-druplig', 'Build with proof generation'

  patch :DATA  

  def install
    if build.with? 'druplig' then
      system 'curl -o lingeling-bbc-9230380-160707-druplig-009.tar.gz http://fmv.jku.at/lingeling/lingeling-bbc-9230380-160707-druplig-009.tar.gz'
      system 'tar zxf lingeling-bbc-9230380-160707-druplig-009.tar.gz'
      Dir.chdir 'lingeling-bbc-9230380-160707-druplig-009' do
        system 'unzip druplig-009.zip'
        system 'mv druplig-009 ../druplig'
      end
      Dir.chdir 'druplig' do
        system './configure.sh'
        system 'make'
      end
    end

    args = []
    if build.with? 'druplig' then
      args << '--druplig=./druplig'
    end
    system "./configure.sh", *args
    system "make"
    bin.install "ilingeling", "lglddtrace", "lglmbt", "lgluntrace",
                "lingeling", "plingeling", "treengeling"
    lib.install "liblgl.a"
    (include/'lingeling').install Dir['*.h']
  end

end

__END__
diff --git a/configure.sh b/configure.sh
index 097f446..744b798 100755
--- a/configure.sh
+++ b/configure.sh
@@ -80,7 +80,7 @@ do
     --no-aiger) aiger=no;;
     --yalsat=*) yalsat=`echo "$1"|sed -e 's,^--yalsat=,,'`;;
     --no-yalsat) yalsat=no;;
-    --druplig) druplig=`echo "$1"|sed -e 's,^--druplig=,,'`;;
+    --druplig=*) druplig=`echo "$1"|sed -e 's,^--druplig=,,'`;;
     --no-druplig) druplig=no;;
     --files) files=yes;;
     --classify) classify=yes;;

