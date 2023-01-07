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

    # Compile Python bindings.
    Dir.chdir 'python' do
      system "python3 setup.py build"
    end
    mkdir_p "#{pylocal}"
    pylocal.install "python/mathsat.py", Dir["python/build/lib*/_mathsat*.so"]

    # Install MathSat.
    Dir.chdir "lib" do
      system "install_name_tool -id @rpath/libmathsat.dylib libmathsat.dylib"
      system "install_name_tool -change /opt/local/lib/libgmp.10.dylib @rpath/libgmp.10.dylib libmathsat.dylib"
    end
    bin.install 'bin/mathsat'
    include.install 'include/mathsat.h', 'include/mathsatll.h', 'include/msatexistelim.h'
    lib.install 'lib/libmathsat.a', 'lib/libmathsat.dylib'
    (share/'mathsat').install 'configurations', 'examples'

    # Compile and install Java library.
    Dir.chdir "java" do
      system "sed -i.bak -e 's,MATHSAT_DIR=..,MATHSAT_DIR=#{prefix},g' compile.sh"
      system "sed -i.bak -e 's,JAVA_DIR=.*,JAVA_DIR=`/usr/libexec/java_home`,g' compile.sh"
      system "sed -i.bak -e 's,GMP_INCLUDE_DIR=.*,GMP_INCLUDE_DIR=#{HOMEBREW_PREFIX}/include,g' compile.sh"
      system "sed -i.bak -e 's,GMP_LIB_DIR=.*,GMP_LIB_DIR=#{HOMEBREW_PREFIX}/lib,g' compile.sh"
      system "sed -i.bak -e 's,soname,install_name,g' compile.sh"
      system "sed -i.bak -e 's,linux,darwin,g' compile.sh"
      system "sed -i.bak -e 's,.so,.dylib,g' compile.sh"
      system "./compile.sh"
      lib.install 'libmathsatj.dylib', 'mathsat.jar'
    end
    File.open("mathsatj-compile", "w") { |f|
      f.puts("#!/bin/sh\n")
      f.puts("`/usr/libexec/java_home`/bin/javac -cp #{HOMEBREW_PREFIX}/lib/mathsat.jar \"$@\"")
    }
    File.open("mathsatj-run", "w") { |f|
      f.puts("#!/bin/sh\n")
      f.puts("DYLD_LIBRARY_PATH=.:#{HOMEBREW_PREFIX}/lib `/usr/libexec/java_home`/bin/java -cp .:#{HOMEBREW_PREFIX}/lib/mathsat.jar \"$@\"")
    }
    bin.install "mathsatj-compile", "mathsatj-run"

    ohai "Additional scripts are installed to compile and run Java files."
    puts <<-EOS
      To compile a Java file Test.java with mathsat, run
        $ mathsatj-compile Test.java

      To run the class Test.class, run
        $ mathsatj-run Test
    EOS
  end
end
