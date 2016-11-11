require 'formula'

class Smtinterpol < Formula
  homepage 'http://ultimate.informatik.uni-freiburg.de/smtinterpol/index.html'
  url 'http://ultimate.informatik.uni-freiburg.de/smtinterpol/smtinterpol.jar'
  version '2.1-144-g5b37bd7'
  sha256 'ae3ad9c9e7fa1e4ce1db7163460f94a6207b0f07345d8e2093116e7d7243e35c'

  def install
    File.open("smtinterpol", "w") { |f|
      f.puts("#!/bin/sh\n")
      f.puts("java -jar " << (share/'smtinterpol').to_s << "/smtinterpol.jar \"$@\"")
    }
    File.chmod(0755, "smtinterpol")
    bin.install "smtinterpol"
    (share/'smtinterpol').install "smtinterpol.jar"
  end
end
