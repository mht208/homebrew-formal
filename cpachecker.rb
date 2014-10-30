require 'formula'

class Cpachecker < Formula
  homepage 'http://cpachecker.sosy-lab.org'
  url 'https://svn.sosy-lab.org/software/cpachecker/tags/cpachecker-1.3.4/'

  depends_on 'ant'

  def install
    File.open("cpachecker", "w") { |f|
      f.puts("#!/bin/sh\n")
      f.puts((share/'cpachecker').to_s << "/scripts/cpa.sh \"$@\"")
    }
    File.chmod(0755, "cpachecker")
    system "ant jar"
    bin.install "cpachecker"
    (share/'cpachecker').install "Copyright.txt", "License_Apache-2.0.txt",
                                 "NEWS.txt", "README.txt", "config",
                                 "cpachecker.jar", "doc", "lib",
                                 "scripts"
  end
end
