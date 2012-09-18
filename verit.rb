require 'formula'

class TexInstalled < Requirement
  def message; <<-EOS.undent
    A TeX/LaTeX installation is required to install.
    You can obtain the TeX distribution for Mac OS X from:
        http://www.tug.org/mactex/
    Make sure that the TeX/LaTeX executables are in PATH
    after the installation.
    EOS
  end
  def satisfied?
    which 'latex'
  end
  def fatal?
    true
  end
end

class Verit < Formula
  homepage 'http://www.verit-solver.org'
  url 'http://www.verit-solver.org/distrib/veriT-201107.tar.gz'
  sha1 '9e555fd04ca2cd43afb76056cd802b34e51ff695'

  option 'with-doc', 'Install documentations'
  option 'with-proof', 'Build with proof production support'

  if build.include? 'with-doc'
    depends_on 'doxygen'
    depends_on TexInstalled.new
    env :userpaths
  end

  def install
    ENV['CC'] = 'gcc'
    ENV.j1

    inreplace 'Makefile.config', /PROOF_PRODUCTION = NO/, 'PROOF_PRODUCTION = YES'
    system "make"

    bin.install "veriT"
    if build.include? 'with-doc'
      system "make documentation"
      system "make -C doc/user/veriT/latex"
      system "make -C doc/user/libveriT/latex"

      (doc/'user/veriT').install "doc/user/veriT/latex/refman.pdf"
      (doc/'user/veriT/html').install Dir["doc/user/veriT/html/*"]
      man3.install Dir["doc/user/veriT/man/man3/arguments_*.3"]

      (doc/'user/libveriT').install "doc/user/libveriT/latex/refman.pdf"
      (doc/'user/libveriT/html').install Dir["doc/user/libveriT/html/*"]
      man3.install Dir["doc/user/libveriT/man/man3/veriT*.h.3"]

      (doc/'dev/latex').install Dir["doc/dev/latex/*"]
      (doc/'dev/html').install Dir["doc/dev/html/*"]
    end
  end
end
