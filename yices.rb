require 'formula'

class YicesDownloadStrategy < CurlDownloadStrategy
  def _fetch
    if not File.exists? "#{HOMEBREW_CACHE}/yices-1.0.38-x86_64-apple-darwin10.8.0-static-gmp.tar.gz"
      onoe <<-EOS.undent
      Due to license restrictions, we cannot fetch the distributables
      automagically.

      1. Visit http://yices.csl.sri.com/cgi-bin/yices-newlicense.cgi?file=yices-1.0.38-x86_64-apple-darwin10.8.0-static-gmp.tar.gz and click 'I accept'.
      2. Move file to #{HOMEBREW_CACHE}
      3. Rename the tarball to yices-1.0.38.tar.gz.
      4. Install this package again.
      EOS
    end
  end
end

class Yices < Formula
  homepage 'http://yices.csl.sri.com'
  url 'http://yices.csl.sri.com/yices-1.0.38-x86_64-apple-darwin10.8.0-static-gmp.tar.gz',
      :using => YicesDownloadStrategy
  sha1 '686e45f2ad5e3fefa3c4c795d12c775b8f333189'

  def install
    bin.install "bin/yices"
    lib.install "lib/libyices.a"
    include.install "include/yices_c.h", "include/yicesl_c.h"
  end

end
