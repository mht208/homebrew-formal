require 'formula'

class YicesDownloadStrategy < CurlDownloadStrategy
  def _fetch
    if not File.exists? "#{HOMEBREW_CACHE}/yices-2.5.1.tar.gz"
      onoe <<-EOS.undent
      Due to license restrictions, we cannot fetch the distributables
      automagically.

      1. Visit http://yices.csl.sri.com/cgi-bin/yices2-newnewlicense.cgi?file=yices-2.5.1-x86_64-apple-darwin15.6.0-static-gmp.tar.gz and click 'I accept'.
      2. Move file to #{HOMEBREW_CACHE}
      3. Rename the tarball to yices-2.5.1.tar.gz.
      4. Install this package again.
      EOS
    end
  end
end

class Yices < Formula
  homepage 'http://yices.csl.sri.com'
  url 'http://yices.csl.sri.com/cgi-bin/yices2-newnewlicense.cgi?file=yices-2.5.1-x86_64-apple-darwin15.6.0-static-gmp.tar.gz',
      :using => YicesDownloadStrategy
  sha256 '15fd2c11072acd7500d0f79a772cd7c252b2ce182f4ee6709997a553035c2b52'

  def install
    system "./install-yices #{prefix}"
  end

end
