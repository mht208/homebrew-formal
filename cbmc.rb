require 'formula'

class Cbmc < Formula
  desc "a Bounded Model Checker for C and C++ programs" 
  homepage "http://www.cprover.org/cbmc/"
  url "https://github.com/diffblue/cbmc.git", :tag => "cbmc-5.10"
  head "https://github.com/diffblue/cbmc.git"

  option "with-jbmc", "Build jbmc"

  depends_on "bison"
  depends_on "flex"
  depends_on "maven"

  def install
    Dir.chdir 'src' do
      system "make minisat2-download"
      system "make"
      bin.install "cbmc/cbmc", "goto-cc/goto-cc", 
                  "goto-instrument/goto-instrument",
                  "goto-analyzer/goto-analyzer",
                  "goto-diff/goto-diff",
                  "solvers/smt2_solver"
    end
    if build.with? 'jbmc'
      Dir.chdir 'jbmc/src' do
        system 'make setup-submodules'
        system 'make'
        bin.install 'jbmc/jbmc'
      end
    end
  end

end
