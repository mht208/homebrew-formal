require 'formula'

class Plingeling < Formula
  homepage 'http://fmv.jku.at/lingeling/'
  url 'http://fmv.jku.at/lingeling/plingeling-ayv-86bf266-140429.zip'
  sha256 'f6ad07da90ebedad6cbff7ed6aa3986820abd6486968fa43b2e516c88e56f01c'

  def install
    Dir.chdir 'code/yalsat' do
      system "./configure.sh -O"
      system "make"
    end
    Dir.chdir 'code/plingeling' do
      system "./configure.sh -O"
      system "make plingeling"
    end
    bin.install "code/yalsat/palsat", "code/yalsat/yalsat"
    lib.install "code/yalsat/libyals.a"
    (include/'lingeling').install "code/yalsat/yals.h", "code/yalsat/yils.h"
    bin.install "code/plingeling/plingeling"
  end

end
