require 'formula'

class Precosat < Formula
  homepage 'http://fmv.jku.at/precosat/'
  url 'http://fmv.jku.at/precosat/precosat-576-7e5e66f-120112.tar.gz'
  version '576'
  sha1 'fedd63c91e5c185eba6d6e8b04b04883ad39e976'

  def install
    system "./configure"
    system "make"
    bin.install "precosat"
  end
end
