require 'formula'

class Cadical < Formula
  homepage 'https://github.com/arminbiere/cadical'
  url 'https://github.com/arminbiere/cadical/archive/rel-1.3.0.tar.gz'
  sha256 '8577c0cbf34eeff6d455e34eb489aae52a0b97b3ef1d02d0c7d2e8a82b572c1b'
  desc 'a SAT solver'

  def install
    system './configure'
    system 'make'
    bin.install 'build/cadical'
    lib.install 'build/libcadical.a'
    (include/'cadical').install 'src/cadical.hpp'
  end

end
