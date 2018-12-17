require 'formula'

class Grat < Formula
  desc 'a SAT solver certificate checking tool chain'
  homepage 'https://www21.in.tum.de/~lammich/grat/'
  url 'https://www21.in.tum.de/~lammich/grat/gratchk.tgz'
  sha256 'f4ef54c4178ebb0b98014b0692525bd851d5ca9ef529b7f49a38fd2ac8718704'
  version 'latest'

  depends_on 'mlton'
  depends_on 'cmake'

  resource 'gratgen' do
    url 'https://www21.in.tum.de/~lammich/grat/gratgen.tgz'
    sha256 '7f4ad462b15525a700f276ef1ad472117c09aa8b66231048372759dcb551ff1f'
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
