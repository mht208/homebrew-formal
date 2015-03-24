require 'formula'

class Cvc4 < Formula
  homepage 'http://cvc4.cs.nyu.edu'
  url 'http://cvc4.cs.nyu.edu/builds/macos/ports/cvc4/cvc4-1.4_2.darwin_13.x86_64.tbz2'
  version '1.4.2'
  sha1 'feced7aae943c95daee389061da2965ea425ff62'

  def install
    bin.install 'opt/local/bin/cvc4'
    include.install 'opt/local/include/cvc4'
    lib.install Dir['opt/local/lib/*']
    doc.install 'opt/local/share/doc/cvc4'
    man.install Dir['opt/local/share/man/*']
  end
end
