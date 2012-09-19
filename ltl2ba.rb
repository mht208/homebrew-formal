require 'formula'

class Ltl2ba < Formula
  homepage 'http://www.lsv.ens-cachan.fr/~gastin/ltl2ba/'
  url 'http://www.lsv.ens-cachan.fr/~gastin/ltl2ba/ltl2ba-1.1.tar.gz'
  sha1 '763325e7801037d2c1a67aba889ea97b389f7d28'

  def install
    system "make"
    bin.install "ltl2ba"
  end
end
