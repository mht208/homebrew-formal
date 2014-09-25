require 'formula'

class Lean < Formula
  homepage 'https://github.com/leanprover/lean'
  version 'master'
  url 'https://github.com/leanprover/lean.git', :branch => 'master'

  depends_on "cmake" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "lua"
  depends_on "google-perftools"
  depends_on "boost"

  option "with-debug", "Build debug version"

  def install
    if build.with? "debug"
      d = "build/debug"
      t = "DEBUG"
    else
      d = "build/release"
      t = "RELEASE"
    end

    mkdir_p "#{d}"
    Dir.chdir "#{d}" do
      system "cmake -DCMAKE_INSTALL_PREFIX:PATH=#{prefix} -DCMAKE_BUILD_TYPE=#{t} -DBOOST=ON ../../src"
      system "make"
      system "make install"
    end
  end
end
