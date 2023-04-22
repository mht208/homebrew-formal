require 'formula'

class Vampire < Formula
  homepage 'https://vprover.github.io'
  desc "Vampire is an automatic theorem prover for first-order logic."
  url 'https://github.com/vprover/vampire/archive/refs/tags/v4.7.tar.gz'
  version '4.7'
  sha256 '330e8bc0a2e10709d41f48b25963017a9d6f527d3ffc6b7b4d4c306b6a5d1da2'

  depends_on 'cmake'

  def install
    Dir.mkdir 'build'

    Dir.chdir 'build' do
      system "cmake .."
      system "make"
      bin.install 'bin/vampire_rel' => 'vampire'
    end
  end
end
