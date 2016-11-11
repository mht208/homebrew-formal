require 'formula'

class Precosat < Formula
  homepage 'http://fmv.jku.at/precosat/'
  url 'http://fmv.jku.at/precosat/precosat-576-7e5e66f-120112.tar.gz'
  version '576'
  sha256 '719cacc83791f181c8879c0cb9bbc1004f0bef50bfa58533f74886c000940c71'

  def install
    system "./configure"
    system "make"
    bin.install "precosat"
  end
end
