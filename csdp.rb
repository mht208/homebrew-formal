require 'formula'

class Csdp < Formula
  desc 'CSDP is a library of routines that implements a predictor corrector variant of the semidefinite programming algorithm of Helmberg, Rendl, Vanderbei, and Wolkowicz'
  homepage 'https://projects.coin-or.org/Csdp'
  url 'https://github.com/coin-or/Csdp/archive/releases/6.1.1.tar.gz'
  sha256 'd4d67dc289e49d113af85fab1ba8dd6929f4d7d53d8234e831498e6642b63a96'

  depends_on 'gcc'

  fails_with :clang do
    build 900
    cause "library not found for -lgfortran"
  end

  def install
    system "make"
    bin.install "solver/csdp", "theta/theta", "theta/graphtoprob",
                "theta/complement", "theta/rand_graph"
    lib.install "lib/libsdp.a"
    (include/"csdp").install Dir["include/*.h"]
  end
end
