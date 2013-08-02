require 'formula'

class Z3 < Formula
  homepage 'http://z3.codeplex.com'
  url 'https://git01.codeplex.com/z3', :tag => 'v4.3.1', :using => :git
  sha1 '80d68d08e15ec40ba314c226f065b2def550fca4'

  depends_on 'autoconf' => :build
  depends_on :python

  def install
    # Although /usr/bin/c++ is a symbolic link to /usr/bin/clang++, it seems that Z3
    # does not like the name c++.
    ENV['CXX'] = "clang++"

    inreplace "scripts/mk_util.py", "distutils.sysconfig.get_python_lib()", "'#{python.site_packages}'"
    system "autoconf"
    system "./configure --prefix=#{prefix}"
    system python, "scripts/mk_make.py"
    mkdir_p "#{python.site_packages}"
    Dir.chdir "build" do
      system "make"
      system "make PREFIX=#{prefix} install"
    end

    ohai "Linking python bindings"
    Dir["#{python.site_packages}/*.pyc"].each do |f|
      path = python.global_site_packages/(Pathname.new(f).basename)
      puts path
      rm path if path.exist?
      ln_s f, path
    end
    puts "#{python.global_site_packages}/libz3.dylib"
    ln_s "#{python.site_packages}/libz3.dylib", "#{python.global_site_packages}/libz3.dylib"
  end
end
