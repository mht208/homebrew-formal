require 'formula'

class Lean < Formula
  homepage 'https://github.com/leanprover/lean'
  version 'master'
  url 'https://github.com/leanprover/lean.git', :branch => 'master'

  depends_on "cmake" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "lua"
  depends_on "gperftools"
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

    (share/"lean").install "library"
  end

  def caveats
    <<-EOS.undent
      Before running lean, execute the following command:
        export LEAN_PATH=#{prefix}/share/lean/library
    EOS
  end
end
