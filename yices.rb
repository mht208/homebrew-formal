require 'formula'

class YicesDownloadStrategy < CurlDownloadStrategy
  def _fetch
    if not File.exists? "#{HOMEBREW_CACHE}/yices-2.3.0-x86_64-apple-darwin13.4.0-static-gmp.tar.gz"
      onoe <<-EOS.undent
      Due to license restrictions, we cannot fetch the distributables
      automagically.

      1. Visit http://yices.csl.sri.com/cgi-bin/yices2-newnewlicense.cgi?file=yices-2.3.0-x86_64-apple-darwin13.4.0-static-gmp.tar.gz and click 'I accept'.
      2. Move file to #{HOMEBREW_CACHE}
      3. Rename the tarball to yices-2.3.0.tar.gz.
      4. Install this package again.
      EOS
    end
  end
end

class Yices < Formula
  homepage 'http://yices.csl.sri.com'
  url 'http://yices.csl.sri.com/cgi-bin/yices2-newnewlicense.cgi?file=yices-2.3.0-x86_64-apple-darwin13.4.0-static-gmp.tar.gz',
      :using => YicesDownloadStrategy
  sha1 '41284b25f5918532f4f04b6da57186717ca242c7'
  version '2.3.0'

  def install
    system "./install-yices #{prefix}"
  end

end
