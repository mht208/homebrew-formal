require 'formula'

class Cbmc < Formula
  homepage 'http://www.cprover.org/cbmc/'
  url 'http://www.cprover.org/svn/cbmc/releases/cbmc-4.7', :using => :svn

  def install
    Dir.chdir 'src' do
      system "make minisat2-download"
      inreplace '../minisat-2.2.0/core/SolverTypes.h',
                'mkLit(Var var, bool sign = false);',
                'mkLit(Var var, bool sign);'
      inreplace '../minisat-2.2.0/core/SolverTypes.h',
                'inline  Lit  mkLit',
                "Lit mkLit(Var var, bool sign = false);\ninline  Lit  mkLit"
      system "make"
      bin.install "cbmc/cbmc"
    end
  end
end
