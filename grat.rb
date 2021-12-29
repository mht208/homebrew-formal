require 'formula'

class Grat < Formula
  desc 'a SAT solver certificate checking tool chain'
  homepage 'https://www21.in.tum.de/~lammich/grat/'
  url 'https://www21.in.tum.de/~lammich/grat/gratchk.tgz'
  sha256 'd24bc831d0079d7d9821c3f6abc0555d23bc1cb1b605b60588e26eaa8c9db4d4'
  version 'latest'

  depends_on 'mlton'
  depends_on 'cmake'
  depends_on 'boost'

  resource 'gratgen' do
    url 'https://www21.in.tum.de/~lammich/grat/gratgen.tgz'
    sha256 'b56acefdf94b5a1e97236ebcb00c83ddf5546fc33573536aca5d82b38d3a6509'
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
