require 'formula'

class Mathsat < Formula
  homepage 'http://mathsat.fbk.eu/index.html'
  url 'http://mathsat.fbk.eu/download.php?file=mathsat-5.2.12-darwin-libcxx-x86_64.tar.gz'
  version '5.2.12'
  sha1 '7ebc3f28b4590b05885520b30b98bd3fbe046029'

  depends_on :python
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
