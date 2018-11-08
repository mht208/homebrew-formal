require 'formula'

class Cryptominisat < Formula
  desc "An advanced SAT Solver"
  homepage "https://www.msoos.org/cryptominisat5/"
  url "https://github.com/msoos/cryptominisat/archive/5.6.5.tar.gz"
  head "https://github.com/msoos/cryptominisat.git"
  sha256 "b2751f8380a59c4885bea4c297536f0af2230306b1458d3e6b78d6e29f37b9d2"

  depends_on "cmake"
  depends_on "boost"
  depends_on "m4ri"
  depends_on "python"

  def install
    system "mkdir build"
    Dir.chdir 'build' do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{prefix} -DM4RI_LIBRARIES=#{HOMEBREW_PREFIX}/lib/libm4ri.a -DM4RI_INCLUDE_DIRS=#{HOMEBREW_PREFIX}/include ../"
      system "make"
      system "make install"
    end
  end

end
