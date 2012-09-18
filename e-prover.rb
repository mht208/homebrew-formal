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
  sha1 'd70add47b1a71ee2139d7e56a9118483dfc79ff5'

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
