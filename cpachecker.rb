require 'formula'

class Cpachecker < Formula
  desc 'CPAchecker is a tool for configurable software verification.'
  homepage 'http://cpachecker.sosy-lab.org'
  url 'https://cpachecker.sosy-lab.org/CPAchecker-2.2-unix.zip'
  sha256 'https://cpachecker.sosy-lab.org/CPAchecker-2.2-unix.zip'

  def install
    File.open("cpachecker", "w") { |f|
      f.puts("#!/bin/sh\n")
      f.puts((share/'cpachecker').to_s << "/scripts/cpa.sh \"$@\"")
    }
    File.chmod(0755, "cpachecker")
    bin.install "cpachecker"
    (share/'cpachecker').install "Authors.txt", "LICENSE",
                                 "NEWS.md", "README.md", "config",
                                 "cpachecker.jar", "doc", "lib",
                                 "scripts"
    ohai <<-EOS.undent
        CPAchecker is installed. But you may need to install
        MathSAT5, JavaSMT, and mathsat5j bindings to run it.
      EOS
  end
end
