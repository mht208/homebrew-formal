require 'formula'

class Yalsat < Formula
  desc 'Yet Another Local Search Solver'
  homepage 'http://fmv.jku.at/yalsat/'
  url 'http://fmv.jku.at/yalsat/yalsat-03s.zip'
  sha256 'bf43b81e06e2ef618c615f8402258d163c79f3c3c9616f4b7f317cbbb6217d87'

  def install
    system "./configure.sh"
    system "make"
    bin.install 'palsat', 'yalsat'
    lib.install 'libyals.a'
    (include/'yalsat').install 'yals.h', 'yils.h'
  end

end
