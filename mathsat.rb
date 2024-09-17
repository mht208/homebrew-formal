require "macho"

class Mathsat < Formula
  desc "Efficient Satisfiability Modulo Theories (SMT) solver"
  homepage "http://mathsat.fbk.eu/index.html"
  url "https://mathsat.fbk.eu/release/mathsat-5.6.11-osx.tar.gz"
  sha256 "c31aeb911310861bfbf480f4fc8e928080ff6da21e490f0ed10a5c2967450ca9"

  depends_on "gmp"
  depends_on "python-setuptools"
  depends_on "python@3"

  def install
    pyver = `python3 --version 2>&1 | awk '{print $2}'`.chomp.gsub(/([0-9]+).([0-9]+).([0-9]+)/, '\1.\2')
    pylocal = (lib/"python#{pyver}/site-packages")
    mkdir_p pylocal.to_s
    # Compile Python bindings.
    Dir.chdir "python" do
      system "python", "setup.py", "build"
      Dir["build/lib*/_mathsat*.so"].each do |so_name|
        MachO::Tools.change_install_name(
          so_name,
          "/Users/alb/src/mathsat_release/build/libmathsat.dylib",
          "@rpath/libmathsat.dylib",
        )
      end
    end
    pylocal.install "python/mathsat.py", Dir["python/build/lib*/_mathsat*.so"]

    # Install MathSat.
    Dir.chdir "lib" do
      MachO.open("libmathsat.dylib") do |dylib|
        dylib.change_dylib_id("@rpath/libmathsat.dylib")
        dylib.change_install_name(
          "/opt/local/lib/libgmp.10.dylib", "@rpath/libgmp.10.dylib"
        )
        dylib.change_install_name(
          "/Users/alb/src/mathsat_release/build/libmathsat.dylib", "@rpath/libmathsat.dylib"
        )
      end
    end
    bin.install "bin/mathsat"
    include.install "include/mathsat.h", "include/mathsatll.h", "include/msatexistelim.h"
    lib.install "lib/libmathsat.a", "lib/libmathsat.dylib"
    (share/"mathsat").install "configurations", "examples"

    # Compile and install Java library.
    Dir.chdir "java" do
      system "sed -i.bak -e 's,MATHSAT_DIR=..,MATHSAT_DIR=#{prefix},g' compile.sh"
      system "sed -i.bak -e 's,JAVA_DIR=.*,JAVA_DIR=`/usr/libexec/java_home`,g' compile.sh"
      system "sed -i.bak -e 's,GMP_INCLUDE_DIR=.*,GMP_INCLUDE_DIR=#{HOMEBREW_PREFIX}/include,g' compile.sh"
      system "sed -i.bak -e 's,GMP_LIB_DIR=.*,GMP_LIB_DIR=#{HOMEBREW_PREFIX}/lib,g' compile.sh"
      system "sed -i.bak -e 's,soname,install_name,g' compile.sh"
      system "sed -i.bak -e 's,linux,darwin,g' compile.sh"
      system "sed -i.bak -e 's,.so,.dylib,g' compile.sh"
      system "sed -i.bak -e 's,CC  -pthread,CC -Wno-int-conversion -pthread,g' compile.sh"
      system "./compile.sh || (cat compile.log && false)"
      MachO::Tools.change_install_name(
        "libmathsatj.dylib",
        "/Users/alb/src/mathsat_release/build/libmathsat.dylib",
        "@rpath/libmathsat.dylib",
      )
      MachO.codesign!("libmathsatj.dylib") if Hardware::CPU.arm?
      lib.install "libmathsatj.dylib"
      libexec.install "mathsat.jar"
    end
    File.open("mathsatj-compile", "w") do |f|
      f.puts("#!/bin/sh\n")
      f.puts("`/usr/libexec/java_home`/bin/javac -cp #{HOMEBREW_PREFIX}/lib/mathsat.jar \"$@\"")
    end
    File.open("mathsatj-run", "w") do |f|
      f.puts("#!/bin/sh\n")
      f.puts("DYLD_LIBRARY_PATH=.:#{HOMEBREW_PREFIX}/lib `/usr/libexec/java_home`/bin/java ")
      f.puts("-cp .:#{HOMEBREW_PREFIX}/lib/mathsat.jar \"$@\"")
    end
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
