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
  url 'http://www.verit-solver.org/distrib/veriT-stable2016.tar.gz'
  sha256 '8bec735297065068d9868da1250f45bccf36dbf9e1029f8b074f62f06323773f'

  option 'with-doc', 'Install documentations'
  option 'without-proof', 'Build without proof production support'

  depends_on 'wget'
  depends_on 'autoconf'

  if build.with? 'doc'
    depends_on 'doxygen'
    depends_on TexInstalled.new
    env :userpaths
  end

  def install
    inreplace 'Makefile.in', '$(INSTALL) veriT $(PREFIX_BIN)', '$(INSTALL) -d $(PREFIX_BIN) && $(INSTALL) veriT $(PREFIX_BIN)/veriT'
    inreplace 'Makefile.in', '$(INSTALL) veriT-SAT $(PREFIX_BIN)', '$(INSTALL) veriT-SAT $(PREFIX_BIN)/veriT-SAT'
    args = ["--prefix=#{prefix}"]
    args << ((build.without? 'proof') ? '--disable-proof' : '')
    system "autoconf"
    system "./configure", *args
    system "make"
    system "make install"
  end

end
