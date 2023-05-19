require 'formula'

class Kissat < Formula
  desc 'a condensed and improved reimplementation of CaDiCaL in C'
  homepage 'http://fmv.jku.at/kissat/'
  url 'https://github.com/arminbiere/kissat/archive/rel-3.0.0.tar.gz'
  sha256 '230895b3beaec5f2c78f6cc520a7db94b294edf244cbad37e2ee6a8a63bd7bdf'
  version '3.0.0'

  def install
    system './configure'
    system 'make'
    bin.install 'build/kissat'
    lib.install 'build/libkissat.a'
    (include/'kissat').install 'src/kissat.h'
  end
end
