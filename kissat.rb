require 'formula'

class Kissat < Formula
  desc 'a condensed and improved reimplementation of CaDiCaL in C'
  homepage 'http://fmv.jku.at/kissat/'
  url 'https://github.com/arminbiere/kissat/archive/sc2020.tar.gz'
  sha256 'a1adb4f2be535bec9126c451b2b49e0142997ba0b2ac79280a48aa575b4426dd'
  version 'sc2020'

  def install
    system './configure'
    system 'make'
    bin.install 'build/kissat'
    lib.install 'build/libkissat.a'
    (include/'kissat').install 'src/kissat.h'
  end

end
