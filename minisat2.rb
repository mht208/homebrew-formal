require 'formula'

class Minisat2 < Formula
  homepage 'http://minisat.se/MiniSat.html'
  url 'http://minisat.se/downloads/minisat2-070721.zip'
  sha1 'cb4a58f8a8192a65b1b944c4307afdf029d51e1c'

  option 'with-simp', 'Build with simplification capabilities'

  def install
    d = (build.include? 'with-simp') ? 'simp' : 'core'
    Dir.chdir d do
      system "make r lib CXX=g++"
      bin.install 'minisat_release' => 'minisat2'
      lib.install 'libminisat.a' => 'libminisat2.a'
    end
    (include/'minisat2/core').install 'core/Solver.h'
    (include/'minisat2/mtl').install Dir['mtl/*.h']
    (include/'minisat2/simp').install 'simp/SimpSolver.h'
  end
end
