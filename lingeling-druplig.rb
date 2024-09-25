require 'formula'

class LingelingDruplig < Formula
  homepage 'http://fmv.jku.at/lingeling/'
  url 'http://fmv.jku.at/lingeling/lingeling-druplig-azd-0d99752-140506.zip'
  sha256 '08a974432b079b2f7a99d467df08799b3d628e6270b10a9642e9c8e25556fe08'

  def install
    Dir.chdir 'code/druplig' do
      system "./configure.sh"
      system "make"
    end
    Dir.chdir 'code/lingeling' do
      system "./configure.sh -O"
      system "make lingeling"
    end
    lib.install "code/druplig/libdruplig.a"
    (include/'lingeling').install "code/druplig/druplig.h"
    bin.install "code/lingeling/lingeling" => "lingeling-druplig"
  end

end
