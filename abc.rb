require 'formula'

class Abc < Formula
  homepage 'http://www.eecs.berkeley.edu/~alanmi/abc/'
  head 'https://github.com/berkeley-abc/abc',
      :revision => "a9237f50ea01efdd62f86d334a38ffbe80a3d141",
      :using => :git
  version "a9237f5"
  sha256 '2317424ff4b065e0eeee0d80807acc36889a1f3c2f976567e08e0c12d331c3a1'

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
