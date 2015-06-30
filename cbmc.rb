require 'formula'

class Cbmc < Formula
  homepage 'http://www.cprover.org/cbmc/'
  url 'http://www.cprover.org/svn/cbmc/releases/cbmc-5.1', :using => :svn

  def install
    Dir.chdir 'src' do
      system "make minisat2-download"
      system "make"
      bin.install "cbmc/cbmc", "goto-cc/goto-cc", 
                  "goto-instrument/goto-instrument"
    end
  end
end
