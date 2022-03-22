require 'formula'

class Mathsat < Formula
  homepage 'http://mathsat.fbk.eu/index.html'
  url 'https://mathsat.fbk.eu/release/mathsat-5.6.6-darwin-libcxx-x86_64.tar.gz'
  version '5.6.6'
  sha256 'e87e42778b701d76935c216faa0233a6654dbd50ec9a03c1f7ca074d4e1c65af'

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
