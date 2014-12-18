require 'formula'

class PrismDownloadStrategy < CurlDownloadStrategy
  def _fetch
    if not File.exists? "#{HOMEBREW_CACHE}/prism-4.2.1-src.tar.gz"
      onoe <<-EOS.undent
      Please download the source code of version 4.2.1 from the webpage of
      PRISM (http://www.prismmodelchecker.org/download.php), rename the
      downloaded file to prism-4.2.1.tar.gz, and move the file to
      #{HOMEBREW_CACHE}.
      EOS
    end
  end
end

class Prism < Formula
  homepage 'http://www.prismmodelchecker.org'
  url 'prism-4.2.1-src.tar.gz', :using => PrismDownloadStrategy
  version '4.2.1'
  sha1 'd029a3c140ac739e9d80095d29d9b0c7ae8007d0'

  def install
    system "make clean_all"
    system "make OSTYPE=darwin"
    (share/'prism').install "bin", "classes", "doc", "etc", "examples",
                            "images", "install.sh", "lib"
    Dir.chdir "#{share}/prism" do
      system "./install.sh"
    end
    mkdir "#{bin}"
    ln_s "#{share}/prism/bin/prism", "#{bin}/prism"
    ln_s "#{share}/prism/bin/xprism", "#{bin}/xprism"
    ohai "The PRISM package is installed in #{HOMEBREW_PREFIX}/share/prism."
  end
end
