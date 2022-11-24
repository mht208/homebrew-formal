require 'formula'

class Mathsat < Formula
  homepage 'http://mathsat.fbk.eu/index.html'
  url 'https://mathsat.fbk.eu/release/mathsat-5.6.9-osx.tar.gz'
  version '5.6.9'
  sha256 '043af0f6501c3adb0c75702282925a72b6ca148b2b2e20b2962e875cad6c158a'

  depends_on 'gmp'
  depends_on 'python'

  def install
    pyver = `python3 --version 2>&1 | awk '{print $2}'`.chomp.gsub(/([0-9]+).([0-9]+).([0-9]+)/, '\1.\2')
    pylocal = (lib/"python#{pyver}/site-packages")

    # Compile python bindings.
    Dir.chdir 'python' do
      system "python3 setup.py build"
    end

    # Install.
    bin.install 'bin/mathsat'
    include.install 'include/mathsat.h', 'include/mathsatll.h', 'include/msatexistelim.h'
    lib.install 'lib/libmathsat.a', 'lib/libmathsat.dylib'
    (share/'mathsat').install 'configurations', 'examples'
    mkdir_p "#{pylocal}"
    pylocal.install "python/mathsat.py", Dir["python/build/lib*/_mathsat*.so"]
  end
end
