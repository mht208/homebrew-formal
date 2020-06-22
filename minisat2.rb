require 'formula'

class Minisat2 < Formula
  homepage 'http://minisat.se/MiniSat.html'
  url 'http://minisat.se/downloads/minisat-2.2.0.tar.gz'
  sha256 '92957d851cdc3baddfe07b5fc80ed5a0237c489d0c52ae72f62844b3b46d7808'

  option 'without-simp', 'Build without simplification capabilities'

  patch :DATA

  def install
    d = (build.without? 'simp') ? 'core' : 'simp'
    Dir.chdir d do
      system "LIB=minisat make r libr libsh MROOT=../"
      bin.install 'minisat_release' => 'minisat'
      lib.install 'libminisat_release.a' => 'libminisat.a'
      lib.install 'libminisat.dylib'
    end
    (include/'minisat').install Dir['core/*.h'], Dir['mtl/*.h'],
                                Dir['simp/*.h'], Dir['utils/*.h']
    ln_s include/'minisat', include/'minisat/core'
    ln_s include/'minisat', include/'minisat/mtl'
    ln_s include/'minisat', include/'minisat/simp'
    ln_s include/'minisat', include/'minisat/utils'
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
diff --git a/mtl/template.mk b/mtl/template.mk
index 3f443fc..2d30a41 100644
--- a/mtl/template.mk
+++ b/mtl/template.mk
@@ -39,6 +39,7 @@ libs:	lib$(LIB)_standard.a
 libp:	lib$(LIB)_profile.a
 libd:	lib$(LIB)_debug.a
 libr:	lib$(LIB)_release.a
+libsh:  lib$(LIB).dylib
 
 ## Compile options
 %.o:			CFLAGS +=$(COPTIMIZE) -g -D DEBUG
@@ -64,7 +65,7 @@ lib$(LIB)_standard.a:	$(filter-out */Main.o,  $(COBJS))
 lib$(LIB)_profile.a:	$(filter-out */Main.op, $(PCOBJS))
 lib$(LIB)_debug.a:	$(filter-out */Main.od, $(DCOBJS))
 lib$(LIB)_release.a:	$(filter-out */Main.or, $(RCOBJS))
-
+lib$(LIB).dylib:        $(filter-out */Main.or, $(RCOBJS))
 
 ## Build rule
 %.o %.op %.od %.or:	%.cc
@@ -81,6 +82,9 @@ lib$(LIB)_standard.a lib$(LIB)_profile.a lib$(LIB)_release.a lib$(LIB)_debug.a:
 	@echo Making library: "$@ ( $(foreach f,$^,$(subst $(MROOT)/,,$f)) )"
 	@$(AR) -rcsv $@ $^
 
+lib$(LIB).dylib:
+	$(CXX) $(LFLAGS) -o $@ -shared -Wl -install_name $@ -o $@ $^
+
 ## Library Soft Link rule:
 libs libp libd libr:
 	@echo "Making Soft Link: $^ -> lib$(LIB).a"

