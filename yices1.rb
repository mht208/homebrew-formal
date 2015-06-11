require 'formula'

class YicesDownloadStrategy < CurlDownloadStrategy
  def _fetch
    if not File.exists? "#{HOMEBREW_CACHE}/yices1-1.0.40.tar.gz"
      onoe <<-EOS.undent
      Due to license restrictions, we cannot fetch the distributables
      automagically.

      1. Visit http://yices.csl.sri.com/cgi-bin/yices-newlicense.cgi?file=yices-1.0.40-x86_64-apple-darwin10.8.0-static-gmp.tar.gz and click 'I accept'.
      2. Move file to #{HOMEBREW_CACHE}
      3. Rename the tarball to yices1-1.0.40.tar.gz.
      4. Install this package again.
      EOS
    end
  end
end

class Yices1 < Formula
  homepage 'http://yices.csl.sri.com'
  url 'http://yices.csl.sri.com/cgi-bin/yices-newlicense.cgi?file=yices-1.0.40-x86_64-apple-darwin10.8.0-static-gmp.tar.gz',
      :using => YicesDownloadStrategy
  sha1 '988facd5be57d7502c491ad36e3c378b77ece931'
  version '1.0.40'

  def install
    bin.install 'bin/yices' => 'yices1'
    (lib/"yices1").install 'lib/libyices.a'
    (include/"yices1").install 'include/yices_c.h', 'include/yicesl_c.h'
  end

end
