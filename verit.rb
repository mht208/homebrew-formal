require 'formula'

class Verit < Formula
  homepage 'http://www.verit-solver.org'
  url 'https://www.verit-solver.org/download/tip/verit-2021.06-1-g8735d9c-rmx.tar.gz'
  sha256 '7190b10ee9c31200a80723f3b160739d8b19bb594a1e81ce691a7c982171911b'

  def install
    args = ["--prefix=#{prefix}"]
    system "./configure", *args
    system "make"
    bin.install "veriT"
    bin.install "veriT-SAT"
  end

end
