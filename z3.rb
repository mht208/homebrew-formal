require 'formula'

class Z3 < Formula
  homepage 'http://z3.codeplex.com'
  url 'https://git01.codeplex.com/z3', :tag => 'v4.3.1', :using => :git
  sha1 '80d68d08e15ec40ba314c226f065b2def550fca4'

  depends_on 'autoconf' => :build
  depends_on 'python'

  def install
    pyver = `python --version 2>&1 | awk '{print $2}'`.chomp.gsub(/([0-9]+).([0-9]+).([0-9]+)/, '\1.\2')
    pylocal = lib.to_s << "/python#{pyver}/site-packages"
    pyglobal = "/usr/local/lib/python#{pyver}/site-packages"

    inreplace "scripts/mk_util.py", "distutils.sysconfig.get_python_lib()", "'#{pylocal}'"
    system "autoconf"
    system "./configure --prefix=#{prefix}"
    system "python scripts/mk_make.py"
    mkdir_p "#{pylocal}"

    Dir.chdir "build" do
      system "make"
      system "make PREFIX=#{prefix} install"
    end

    ohai "Linking python bindings"
    Dir["#{pylocal}/*.pyc"].each do |f|
      path = Pathname.new(pyglobal) + Pathname.new(f).basename
      puts path
      rm path if path.exist?
      ln_s f, path
    end
  end
end
