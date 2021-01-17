require 'formula'

class Boolector < Formula
  include Language::Python::Virtualenv

  desc 'an SMT solver'
  homepage 'http://fmv.jku.at/boolector/'
  url 'https://github.com/Boolector/boolector/archive/3.2.0.tar.gz'
  sha256 '5065ed4032f2761aff509a99df2124c0de1ab4fc8e7407d271946c92d564f268'

  depends_on 'cmake'
  depends_on 'python@3.9'
  depends_on 'gmp'
  depends_on 'sphinx-doc'

  patch :DATA

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/6c/9f/f501ba9d178aeb1f5bf7da1ad5619b207c90ac235d9859961c11829d0160/Cython-0.29.21.tar.gz"
    sha256 "e57acb89bd55943c8d8bf813763d20b9099cc7165c0f16b707631a7654be9cad"
  end

  def install
    venv_root = libexec/"venv"
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", "#{venv_root}/lib/python#{xy}/site-packages"
    ENV.prepend_path "PATH", "#{venv_root}/bin"
    venv = virtualenv_create(venv_root, "python3")
    venv.pip_install resource("Cython")

    # Build dependencies
    system "./contrib/setup-btor2tools.sh"
    system "./contrib/setup-cadical.sh"
    system "./contrib/setup-lingeling.sh"

    args = ["--prefix", "#{prefix}", "--python", "--py3", "--gmp"]

    # Configure Boolector
    system "./configure.sh", *args

    # Compile Boolector
    Dir.chdir 'build' do
      system "make"
    end

    # Compile documentation
    Dir.chdir 'doc' do
      system "make", "html"
      system "make", "man"
    end

    # Install
    Dir.chdir 'build' do
      system "make", "install"
    end

    (share/'boolector').install 'doc/_build/html'
    man1.install 'doc/_build/man/boolector.1'
    (share/'boolector').install 'examples'
  end

end

__END__
diff --git a/contrib/setup-cadical.sh b/contrib/setup-cadical.sh
index ddddc9c..006dca5 100755
--- a/contrib/setup-cadical.sh
+++ b/contrib/setup-cadical.sh
@@ -21,7 +21,7 @@ if is_windows; then
   #
   export CXXFLAGS=""
 else
-  export CXXFLAGS="-fPIC"
+  export CXXFLAGS="-fPIC -std=c++0x"
 fi
 
 ./configure ${EXTRA_FLAGS}

