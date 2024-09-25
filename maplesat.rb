require 'formula'

class Maplesat < Formula
  desc 'A Machine Learning based SAT Solver'
  homepage 'https://sites.google.com/a/gsd.uwaterloo.ca/maplesat/'
  url 'https://sites.google.com/a/gsd.uwaterloo.ca/maplesat/MapleSAT.zip?attredirects=0&d=1'
  version '0'
  sha256 'dd2a3445bf7d58338e39d295b7080021a4e00f116427ecf4e6a0ea4390e8e16e'

  patch :DATA

  def install
    Dir.chdir 'simp' do
      system 'MROOT=.. make r'
      bin.install 'maplesat_release' => 'maplesat'
    end
  end

end

__END__
diff --git a/core/SolverTypes.h b/core/SolverTypes.h
index 323df68..3c98350 100644
--- a/core/SolverTypes.h
+++ b/core/SolverTypes.h
@@ -82,7 +82,7 @@ struct Lit {
     int     x;
 
     // Use this as a constructor:
-    friend Lit mkLit(Var var, bool sign = false);
+    friend Lit mkLit(Var var, bool sign);
 
     bool operator == (Lit p) const { return x == p.x; }
     bool operator != (Lit p) const { return x != p.x; }
@@ -90,7 +90,7 @@ struct Lit {
 };
 
 
-inline  Lit  mkLit     (Var var, bool sign) { Lit p; p.x = var + var + (int)sign; return p; }
+inline  Lit  mkLit     (Var var, bool sign = false) { Lit p; p.x = var + var + (int)sign; return p; }
 inline  Lit  operator ~(Lit p)              { Lit q; q.x = p.x ^ 1; return q; }
 inline  Lit  operator ^(Lit p, bool b)      { Lit q; q.x = p.x ^ (unsigned int)b; return q; }
 inline  bool sign      (Lit p)              { return p.x & 1; }
diff --git a/utils/System.cc b/utils/System.cc
index a7cf53f..900653a 100644
--- a/utils/System.cc
+++ b/utils/System.cc
@@ -88,7 +88,7 @@ double Minisat::memUsed(void) {
     malloc_statistics_t t;
     malloc_zone_statistics(NULL, &t);
     return (double)t.max_size_in_use / (1024*1024); }
-
+double Minisat::memUsedPeak(void) { return memUsed(); }
 #else
 double Minisat::memUsed() { 
     return 0; }

