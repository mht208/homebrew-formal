require 'formula'

class Cpachecker < Formula
  desc 'CPAchecker is a tool for configurable software verification.'
  homepage 'http://cpachecker.sosy-lab.org'
  url 'https://svn.sosy-lab.org/software/cpachecker/tags/cpachecker-1.7/'

  depends_on 'ant'

  def install
    inreplace 'build/build-ivy.xml', 'https', 'http'
    File.open("cpachecker", "w") { |f|
      f.puts("#!/bin/sh\n")
      f.puts((share/'cpachecker').to_s << "/scripts/cpa.sh \"$@\"")
    }
    File.chmod(0755, "cpachecker")
    system "ant jar"
    bin.install "cpachecker"
    (share/'cpachecker').install "Copyright.txt", "License_Apache-2.0.txt",
                                 "NEWS.txt", "README.md", "config",
                                 "cpachecker.jar", "doc", "lib",
                                 "scripts"
    ohai <<-EOS.undent
        CPAchecker is installed. But you may need to install
        MathSAT5, JavaSMT, and mathsat5j bindings to run it.
      EOS
  end
end
