require 'formula'

class Cvc4 < Formula
  homepage 'http://cvc4.cs.nyu.edu'
  url 'http://cvc4.cs.nyu.edu/builds/src/cvc4-1.3.tar.gz'
  sha1 '886f108ca8355bda3c34ffc694ea9a22710f6585'

  option 'with-cln', 'Build with CLN instead of GMP'
  option 'with-static', 'Build static linked binaries'
  option 'with-debug', 'Build debug version'
  option 'with-java', 'Build with Java support'

  depends_on 'boost'
  depends_on 'libantlr3c'
  if build.with? 'cln'
    depends_on 'cln'
  else
    depends_on 'gmp'
  end

  def patches
    # Friend functions cannot have default arguments.
    DATA
  end

  def install
    if build.with? 'static' and build.with? 'java'
      fail 'The Java interface requires a dynamic library build.'
    end

    #{ENV.cxx} = 'g++'
    ENV.O2
    ENV['CXXFLAGS'] = '-stdlib=libc++'
    ENV['CPPFLAGS'] = '-stdlib=libc++'
    args = ["--prefix=#{prefix}", "CXXFLAGS='-stdlib=libstdc++'", "CPPFLAGS='-stdlib=libstdc++'"]
    args << ((build.with? 'cln') ? '--with-cln' : '--with-gmp')
    args << ((build.with? 'static') ? '--enable-static' : '--enable-dynamic')
    args << ((build.with? 'debug') ? '--with-build=debug' : '--with-build=production')
    if build.with? 'java'
      args << '--enable-language-bindings=all' << '--with-java-home=/System/Library/Frameworks/JavaVM.framework/Home' << '--with-java-includes=/System/Library/Frameworks/JavaVM.framework/Headers'
    else
      args << '--enable-language-bindings=c,c++'
    end
    system "./configure", *args
    system "make"
    system "make install"
  end
end

__END__
diff --git a/src/prop/bvminisat/core/SolverTypes.h b/src/prop/bvminisat/core/SolverTypes.h
index 89ffc8a..eeb02c9 100644
--- a/src/prop/bvminisat/core/SolverTypes.h
+++ b/src/prop/bvminisat/core/SolverTypes.h
@@ -46,13 +46,15 @@ struct Lit {
     int     x;
 
     // Use this as a constructor:
-    friend Lit mkLit(Var var, bool sign = false);
+    friend Lit mkLit(Var var, bool sign);
 
     bool operator == (Lit p) const { return x == p.x; }
     bool operator != (Lit p) const { return x != p.x; }
     bool operator <  (Lit p) const { return x < p.x;  } // '<' makes p, ~p adjacent in the ordering.
 };
 
+Lit mkLit(Var var, bool sign = false);
+
 inline  Lit  mkLit     (Var var, bool sign) { Lit p; p.x = var + var + (int)sign; return p; }
 inline  Lit  operator ~(Lit p)              { Lit q; q.x = p.x ^ 1; return q; }
 inline  Lit  operator ^(Lit p, bool b)      { Lit q; q.x = p.x ^ (unsigned int)b; return q; }
diff --git a/src/prop/minisat/core/SolverTypes.h b/src/prop/minisat/core/SolverTypes.h
index fac4c92..edb1049 100644
--- a/src/prop/minisat/core/SolverTypes.h
+++ b/src/prop/minisat/core/SolverTypes.h
@@ -49,13 +49,14 @@ struct Lit {
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

