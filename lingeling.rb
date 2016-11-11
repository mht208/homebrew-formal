require 'formula'

class Lingeling < Formula
  homepage 'http://fmv.jku.at/lingeling/'
  url 'http://fmv.jku.at/lingeling/lingeling-ayv-86bf266-140429.zip'
  sha256 '9d1fc5d5804fdc41cb3b8cb2dedabbd3fb27e639b3b1f57e157153665828fb81'

  option 'with-variants', 'Install other variants as well'

  depends_on 'lingeling-druplig' if build.with? 'variants'
  depends_on 'plingeling' if build.with? 'variants'
  depends_on 'treengeling' if build.with? 'variants'

  def install
    Dir.chdir 'code' do
      system "./configure.sh -O"
      system "make lingeling"
      bin.install "lingeling"
      lib.install "liblgl.a"
      (include/'lingeling').install "lgldimacs.h", "lglib.h"
    end
  end

end
