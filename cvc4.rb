require 'formula'

class Cvc4 < Formula
  include Language::Python::Virtualenv

  homepage 'http://cvc4.cs.nyu.edu'
  url 'https://github.com/CVC4/CVC4-archived/archive/refs/tags/1.8.tar.gz'
  sha256 '80fd10d5e4cca56367fc5398ba0117a86d891e0b9b247a97cd981fe02e8167f5'

  depends_on "coreutils" => :build
  depends_on "cmake" => :build
  depends_on "python@3.9"
  depends_on "gmp" => :build
  depends_on "swig"
  depends_on "flex"

  resource "toml" do
    url 'https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz'
    sha256 'b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f'
  end

  patch :DATA

  def install
    venv_root = libexec/"venv"
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", "#{venv_root}/lib/python#{xy}/site-packages"
    venv = virtualenv_create(venv_root, "python3")
    venv.pip_install resource("toml")

    system "pip3", "install", "toml"
    system "MACHINE_TYPE=\"x86_64\" ./contrib/get-antlr-3.4"
    system "./contrib/get-symfpu"
    system "./contrib/get-cadical"
    system "./contrib/get-kissat"
    system "./contrib/get-cryptominisat"
    system "./contrib/get-lfsc-checker"
    args = [ "--prefix=#{prefix}",
             "--cadical",
             "--kissat",
             "--cryptominisat",
             "--lfsc",
             "--python3",
             "--symfpu" ]
    system "./configure.sh", *args
    chdir "build" do
      system "make"
      system "make", "install"
    end
  end
end

__END__
diff --git a/contrib/get-cadical b/contrib/get-cadical
index a253514..a459538 100755
--- a/contrib/get-cadical
+++ b/contrib/get-cadical
@@ -10,7 +10,7 @@ setup_dep \
   "https://github.com/arminbiere/cadical/archive/$version.tar.gz" "$CADICAL_DIR"
 cd "$CADICAL_DIR"
 
-CXXFLAGS="-fPIC" ./configure && make -j$(nproc)
+CXXFLAGS="-fPIC -std=c++0x" ./configure && make -j$(nproc)
 
 install_lib build/libcadical.a
 install_includes src/cadical.hpp
