require 'formula'

class Boolector < Formula
  homepage 'http://fmv.jku.at/boolector/'
  url 'http://fmv.jku.at/boolector/boolector-1.6.0-with-sat-solvers.tar.gz'
  sha1 'c148c882cb8118d1f5ffc96cac7019ea64fd0b2a'

  def patches
    DATA
  end

  def install
    system "./build.sh"
    bin.install "boolector/boolector", "boolector/deltabtor", "boolector/synthebtor"
    lib.install "boolector/libboolector.a"
    include.install Dir['boolector/*.h']
  end

end

__END__
diff --git a/build.sh b/build.sh
index 35955c3..bdac3e0 100755
--- a/build.sh
+++ b/build.sh
@@ -23,6 +23,8 @@ if [ -d minisat ]
 then
   echo "building minisat"
   cd minisat
+  sed -i .bak -e 's/--static //g' -e 's/-soname/-install_name/g' Makefile
+  sed -i .bak -e 's/Minisat::memUsedPeak()/Minisat::memUsedPeak(bool strictlyPeak)/g' minisat/utils/System.cc
   make r >/dev/null || die "'make r' failed in 'minisat'"
   cd ..
 fi

