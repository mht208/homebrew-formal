require 'formula'

class Mathsat < Formula
  homepage 'http://mathsat.fbk.eu/index.html'
  url 'https://mathsat.fbk.eu/release/mathsat-5.6.5-darwin-libcxx-x86_64.tar.gz'
  version '5.6.5'
  sha256 'bf13877df67e1a9529474644de2999ba3b5e314f82a8790138e4ddd5c5cd5bfa'

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
