require 'formula'

class Stp < Formula
  homepage 'https://sites.google.com/site/stpfastprover/STP-Fast-Prover'
  version 'master'
  url 'https://github.com/stp/stp.git', :branch => 'master'

  depends_on 'cmake' => :build

  def install
    d = pwd
    mkdir "build"
    system "cd build && cmake -G 'Unix Makefiles' #{d}"
    system "cd build && make"
    bin.install "build/stp"
    lib.install "build/lib/libstp.a"
    include.install "build/include/stp"
  end
end
