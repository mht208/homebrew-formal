require 'formula'

class PVSDownloadStrategy < CurlDownloadStrategy
  def _fetch
    if not File.exists? "#{HOMEBREW_CACHE}/pvs-5.0.tgz"
      onoe <<-EOS.undent
      Due to license restrictions, we cannot fetch the distributables
      automagically.

      1. Visit http://pvs.csl.sri.com/cgi-bin/downloadlic.cgi?file=pvs-5.0-ix86-MacOSX-allegro.tgz and click 'I accept'.
      2. Move file to #{HOMEBREW_CACHE}
      3. Rename the tarball to pvs-5.0.tgz.
      4. Install this package again.
      EOS
    end
  end
end

class Pvs < Formula
  homepage 'http://pvs.csl.sri.com'
  url 'http://pvs.csl.sri.com/pvs-5.0.tgz',
      :using => PVSDownloadStrategy
  sha256 '04c22567871b5cdeeda4ecf02dc14efb69c6fa28435328abb29a1f8083a5c30d'

  def install
    (share/'pvs').install (Dir.glob "*")
    Dir.chdir "#{prefix}/share/pvs" do
      system "bin/relocate"
    end
    mkdir "#{prefix}/bin"
    ln_s "#{prefix}/share/pvs/pvs", "#{prefix}/bin/pvs"
  end

end
