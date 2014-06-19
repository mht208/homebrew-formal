require 'formula'

class Ispin < Formula
  homepage 'http://spinroot.com/'
  url 'http://spinroot.com/spin/Src/ispin.tcl'
  version '1.1.1'
  sha1 'b017e82cf71ddb0bc8cbbab2fc4c1082c6a4b430'

  def install
    bin.install "ispin.tcl"
  end
end
