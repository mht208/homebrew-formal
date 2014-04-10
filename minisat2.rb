require 'formula'

class Minisat2 < Formula
  homepage 'http://minisat.se/MiniSat.html'
  url 'http://minisat.se/downloads/minisat-2.2.0.tar.gz'
  sha1 'dfc25898bf40e00cf04252a42176e0c0600fbc90'

  option 'with-simp', 'Build with simplification capabilities'

  def patches
    # Fix friend functions with default arguments and add the missing memUsedPeak for Mac OS
    DATA
  end

  def install
    d = (build.with? 'simp') ? 'simp' : 'core'
    Dir.chdir d do
      system "make r libr MROOT=../"
      bin.install 'minisat_release' => 'minisat2'
      lib.install 'lib_release.a' => 'libminisat2.a'
    end
    (include/'minisat2').install Dir['core/*.h'], Dir['mtl/*.h'],
                                 Dir['simp/*.h'], Dir['utils/*.h']
    ln_s include/'minisat2', include/'minisat2/core'
    ln_s include/'minisat2', include/'minisat2/mtl'
    ln_s include/'minisat2', include/'minisat2/simp'
    ln_s include/'minisat2', include/'minisat2/utils'
  end
end


__END__
diff --git a/core/SolverTypes.h b/core/SolverTypes.h
index 1ebcc73..49496ad 100644
--- a/core/SolverTypes.h
+++ b/core/SolverTypes.h
@@ -47,13 +47,14 @@ struct Lit {
     int     x;
 
     // Use this as a constructor:
-    friend Lit mkLit(Var var, bool sign = false);
+    friend Lit mkLit(Var var, bool sign);
 
     bool operator == (Lit p) const { return x == p.x; }
     bool operator != (Lit p) const { return x != p.x; }
     bool operator <  (Lit p) const { return x < p.x;  } // '<' makes p, ~p adjacent in the ordering.
 };
 
+Lit mkLit(Var var, bool sign = false);
 
 inline  Lit  mkLit     (Var var, bool sign) { Lit p; p.x = var + var + (int)sign; return p; }
 inline  Lit  operator ~(Lit p)              { Lit q; q.x = p.x ^ 1; return q; }
diff --git a/utils/System.cc b/utils/System.cc
index a7cf53f..ca5fee2 100644
--- a/utils/System.cc
+++ b/utils/System.cc
@@ -78,7 +78,7 @@ double Minisat::memUsed(void) {
     struct rusage ru;
     getrusage(RUSAGE_SELF, &ru);
     return (double)ru.ru_maxrss / 1024; }
-double MiniSat::memUsedPeak(void) { return memUsed(); }
+double Minisat::memUsedPeak(void) { return memUsed(); }
 
 
 #elif defined(__APPLE__)
@@ -88,7 +88,7 @@ double Minisat::memUsed(void) {
     malloc_statistics_t t;
     malloc_zone_statistics(NULL, &t);
     return (double)t.max_size_in_use / (1024*1024); }
-
+double Minisat::memUsedPeak(void) { return memUsed(); }
 #else
 double Minisat::memUsed() { 
     return 0; }

