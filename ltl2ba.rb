require 'formula'

class Ltl2ba < Formula
  homepage 'http://www.lsv.ens-cachan.fr/~gastin/ltl2ba/'
  url 'http://www.lsv.ens-cachan.fr/~gastin/ltl2ba/ltl2ba-1.1.tar.gz'
  sha256 'a66bf05bc3fd030f19fd0114623d263870d864793b1b0a2ccf6ab6a40e7be09b'

  def install
    system "make"
    bin.install "ltl2ba"
  end
end
