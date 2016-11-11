require 'formula'

class Treengeling < Formula
  homepage 'http://fmv.jku.at/lingeling/'
  url 'http://fmv.jku.at/lingeling/treengeling-ayv-86bf266-140429.zip'
  sha256 'b8075a266c019a48d76006d03672707ea42173148e83d5abc97d388f60dbfe3a'

  def install
    Dir.chdir 'code/yalsat' do
      system "./configure.sh -O"
      system "make"
    end
    Dir.chdir 'code/treengeling' do
      system "./configure.sh -O"
      system "make treengeling"
    end
    bin.install "code/treengeling/treengeling"
  end

end
