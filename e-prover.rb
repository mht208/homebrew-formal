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

class EProver < Formula
  homepage 'http://www4.informatik.tu-muenchen.de/~schulz/E/E.html'
  url 'http://www4.in.tum.de/~schulz/WORK/E_DOWNLOAD/V_1.6/E.tgz'
  version '1.6'
  sha256 '91afe68f37ca2005a8eead3bdba0a4452de7cf7100369c9955304c8609b70c90'

  env :userpaths

  option 'with-doc', 'Install additional documentations (LaTeX is required)'

  depends_on TexInstalled.new if build.include? 'with-doc'

  def install
    system "./configure", "--prefix=#{prefix}", "--man-prefix=#{man1}"
    system "make"
    system "make install"
    if build.include? 'with-doc'
      ENV.j1
      system "make documentation"
      doc.install 'DOC/eprover.pdf'
    end
  end
end
