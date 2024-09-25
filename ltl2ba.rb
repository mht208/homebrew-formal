require 'formula'

class Ltl2ba < Formula
  homepage 'http://www.lsv.ens-cachan.fr/~gastin/ltl2ba/'
  url 'http://www.lsv.fr/~gastin/ltl2ba/ltl2ba-1.2.tar.gz'
  sha256 '9dfe16c2362e953982407eabf773fff49d69b137b13bd5360b241fb4cf2bfb6f'

  def install
    system "make"
    bin.install "ltl2ba"
  end
end
