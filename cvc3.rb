require 'formula'

class Cvc3 < Formula
  homepage 'http://www.cs.nyu.edu/acsys/cvc3/'
  url 'https://cs.nyu.edu/acsys/cvc3/releases/2.4.1/macosx/cvc3-2.4.1-macosx-optimized-static.tar.gz'
  sha256 'df097b0ced956c142c42962245c94d936c0c666a146c64419f6fe0cae5f255f1'

  def install
    bin.install "bin/cvc3"
    include.install "include/cvc3"
    lib.install Dir["lib/*"]
  end
end
