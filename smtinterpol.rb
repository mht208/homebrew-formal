require 'formula'

class Smtinterpol < Formula
  homepage 'http://ultimate.informatik.uni-freiburg.de/smtinterpol/index.html'
  url 'https://ultimate.informatik.uni-freiburg.de/smtinterpol/smtinterpol-2.5-1242-g5c50fb6d.jar'
  version '2.5-1242-g5c50fb6d'
  sha256 '1efc4bf8b824bf2798094cacf1096949606024e4fd6c358be5b98f9105e246d6'

  def install
    File.open("smtinterpol", "w") { |f|
      f.puts("#!/bin/sh\n")
      f.puts("java -jar " << (share/'smtinterpol').to_s << "/smtinterpol-2.5-1242-g5c50fb6d.jar \"$@\"")
    }
    File.chmod(0755, "smtinterpol")
    bin.install "smtinterpol"
    (share/'smtinterpol').install "smtinterpol-2.5-1242-g5c50fb6d.jar"
  end
end
