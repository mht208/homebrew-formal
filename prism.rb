require 'formula'

class PrismDownloadStrategy < CurlDownloadStrategy
  def _fetch
    if not File.exists? "#{HOMEBREW_CACHE}/prism-4.3.1-src.tar.gz"
      onoe <<-EOS.undent
      Please download the source code of version 4.3.1 from the webpage of
      PRISM (http://www.prismmodelchecker.org/download.php), rename the
      downloaded file to prism-4.3.1.tar.gz, and move the file to
      #{HOMEBREW_CACHE}.
      EOS
    end
  end
end

class Prism < Formula
  homepage 'http://www.prismmodelchecker.org'
  url 'prism-4.3.1-src.tar.gz', :using => PrismDownloadStrategy
  version '4.3.1'
  sha256 'c2305b546ddc6619131f0aa9224c64d0f1ada04cebb07b25d1a7ea1aa82f12e8'

  def install
    system "make clean_all"
    system "make OSTYPE=darwin cuddpackage"
    system "make OSTYPE=darwin extpackages"
    system "make OSTYPE=darwin all"
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
