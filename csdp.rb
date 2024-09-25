require 'formula'

class Csdp < Formula
  desc 'CSDP is a library of routines that implements a predictor corrector variant of the semidefinite programming algorithm of Helmberg, Rendl, Vanderbei, and Wolkowicz'
  homepage 'https://projects.coin-or.org/Csdp'
  url 'https://github.com/coin-or/Csdp/archive/releases/6.2.0.tar.gz'
  sha256 '3d341974af1f8ed70e1a37cc896e7ae4a513375875e5b46db8e8f38b7680b32f'

  depends_on "gcc"

  fails_with :clang do
    cause "symbol(s) not found"
  end

  patch :DATA

  def install
    system "make"
    bin.install "solver/csdp", "theta/theta", "theta/graphtoprob",
                "theta/complement", "theta/rand_graph"
    lib.install "lib/libsdp.a"
    (include/"csdp").install Dir["include/*.h"]
  end
end

__END__
diff --git a/Makefile b/Makefile
index 3430806..e0faf9c 100644
--- a/Makefile
+++ b/Makefile
@@ -15,7 +15,7 @@ export CFLAGS=-m64 -march=native -mtune=native -Ofast -fopenmp -ansi -Wall -DBIT
 #
 # LIBS settings for 64 bit Linux/unix systems.
 #
-export LIBS=-static -L../lib -lsdp -llapack -lblas -lm
+export LIBS=-L../lib -lsdp -llapack -lblas -lm
 #
 #
 # On most systems, this should handle everything.
