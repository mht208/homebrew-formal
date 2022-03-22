require 'formula'

class Vampire < Formula
  homepage 'https://vprover.github.io'
  desc "Vampire is an automatic theorem prover for first-order logic."
  url 'https://github.com/vprover/vampire/archive/refs/tags/v4.6.1.tar.gz'
  version '4.6.1'
  sha256 '68c61db1085d4aa55b94012533a9fc779ae858ffcc1df4a84312f48a8a31902a'

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
