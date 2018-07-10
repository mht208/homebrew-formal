require 'formula'

class Mathsat < Formula
  homepage 'http://mathsat.fbk.eu/index.html'
  url 'http://mathsat.fbk.eu/download.php?file=mathsat-5.5.2-darwin-libcxx-x86_64.tar.gz'
  version '5.5.2'
  sha256 'a0a46c99fb100c3303d2fbca0caee9f274315191fc90b322b02df84ffe210350'

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
    include.install 'include/mathsat.h', 'include/mathsatll.h', 'include/msatexistelim.h'
    lib.install 'lib/libmathsat.a', 'lib/libmathsat.dylib'
    (share/'mathsat').install 'configurations', 'examples'
    mkdir_p "#{pylocal}"
    pylocal.install "python/mathsat.py", Dir["python/build/lib*/_mathsat.so"]
  end
end
