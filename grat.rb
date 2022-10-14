require 'formula'

class Grat < Formula
  desc 'a SAT solver certificate checking tool chain'
  homepage 'https://www21.in.tum.de/~lammich/grat/'
  url 'https://www21.in.tum.de/~lammich/grat/gratchk.tgz'
  sha256 '9711ace16585ad602a0921a8d676e9fca7323d04fd158a93e5367a212446f8c9'
  version 'latest'

  depends_on 'mlton'
  depends_on 'cmake'
  depends_on 'boost'

  resource 'gratgen' do
    url 'https://www21.in.tum.de/~lammich/grat/gratgen.tgz'
    sha256 'f0bcd5d7a59952de7cd42349eeaafc6661a901215d044fba4fc5d2b549e92bb6'
  end

  def install
    resource('gratgen').stage do
      system 'cmake', '.'
      system 'make'
      bin.install 'gratgen'
    end
    Dir.chdir 'code' do
      system 'make'
      bin.install 'gratchk'
    end
  end

end
