require 'formula'

class Abc < Formula
  homepage 'http://www.eecs.berkeley.edu/~alanmi/abc/'
  url 'https://bitbucket.org/alanmi/abc/get/192d4ce70b5e.zip', :using => CurlDownloadStrategy
  version '192d4ce70b5e'
  sha256 'ca51ed3ecc5b10bdbd9494250fb7991dfcd7ddc83cd9cdfba925926f6a7d02d4'

  def install
    system "make"
    system "make", "ABC_USE_PIC=1", "libabc.so"
    system "mv", "libabc.so", "libabc.dylib"
    system "mkdir", "include"
    system "find ./src -name *.h -type f -print0 | xargs -0 -I '{}' /usr/bin/rsync -avR \"{}\" include/"
    bin.install "abc"
    lib.install "libabc.dylib"
    (include/'abc').install Dir['include/src/*']
    (share/'abc/scripts').install "abc.rc"
    ohai "The abc resource file has been installed to #{share}/abc/scripts/abc.rc. You may create a symbolic link ~/.abc.rc to the resource file such that alias commands can be used."
  end

end
