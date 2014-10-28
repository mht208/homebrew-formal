require 'formula'

class Treengeling < Formula
  homepage 'http://fmv.jku.at/lingeling/'
  url 'http://fmv.jku.at/lingeling/treengeling-ayv-86bf266-140429.zip'
  sha1 '7432d7ad749801e741523102ec2848fa4286e34c'

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
