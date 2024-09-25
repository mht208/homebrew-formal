require 'formula'

class Yalsat < Formula
  desc 'Yet Another Local Search Solver'
  homepage 'http://fmv.jku.at/yalsat/'
  url 'http://fmv.jku.at/yalsat/yalsat-03v.zip'
  sha256 '596ad9eb729ddfd67c2256adb20ff8d4d9d7018004d838f6b4e449b8b5be426a'

  def install
    system "./configure.sh"
    system "make"
    bin.install 'palsat', 'yalsat'
    lib.install 'libyals.a'
    (include/'yalsat').install 'yals.h', 'yils.h'
  end

end
