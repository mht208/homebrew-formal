require 'formula'

class Smtinterpol < Formula
  homepage 'http://ultimate.informatik.uni-freiburg.de/smtinterpol/index.html'
  url 'http://ultimate.informatik.uni-freiburg.de/smtinterpol/smtinterpol.jar'
  version '2.1-144-g5b37bd7'
  sha1 'ac137aa85219631116fafd899a6c189ea4d44968'

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
