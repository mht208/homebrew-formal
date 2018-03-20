require 'formula'

class Mathsat < Formula
  homepage 'http://mathsat.fbk.eu/index.html'
  url 'http://mathsat.fbk.eu/download.php?file=mathsat-5.2.12-darwin-libcxx-x86_64.tar.gz'
  version '5.2.12'
  sha256 'e6f72b94aba0fb894fc8fdac1d92a3cd96538f990324a47e150455a34c065c56'

  depends_on 'gmp'

  def install
    pyver = `python --version 2>&1 | awk '{print $2}'`.chomp.gsub(/([0-9]+).([0-9]+).([0-9]+)/, '\1.\2')
    pylocal = (lib/"python#{pyver}/site-packages")

    # Compile python bindings.
    Dir.chdir 'python' do
      system "python setup.py build"
    end

    # Install.
    bin.install 'bin/mathsat'
    include.install 'include/mathsat.h'
    lib.install 'lib/libmathsat.a'
    (share/'mathsat').install 'configurations', 'examples'
    mkdir_p "#{pylocal}"
    pylocal.install "python/mathsat.py", Dir["python/build/lib*/_mathsat.so"]
  end
end
