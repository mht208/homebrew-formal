class Boolector < Formula
  include Language::Python::Virtualenv
  desc "SMT solver"
  homepage "http://fmv.jku.at/boolector/"
  url "https://github.com/Boolector/boolector/archive/refs/tags/3.2.2.tar.gz"
  sha256 "9a5bdbacf83f2dd81dbed1e1a9f923766807470afa29b73729c947ae769d42b9"

  depends_on "cmake"
  depends_on "cython"
  depends_on "gmp"
  depends_on "python@3.9"
  depends_on "sphinx-doc"

  def install
    # Build dependencies
    system "./contrib/setup-btor2tools.sh"
    system "./contrib/setup-cadical.sh"
    system "./contrib/setup-lingeling.sh"

    # Configure Boolector
    args = ["--prefix", "#{prefix}", "--python", "--py3", "--gmp"]
    system "./configure.sh", *args

    # Compile Boolector
    Dir.chdir "build" do
      system "make"
    end

    # Compile documentation
    Dir.chdir "doc" do
      system "make", "man"
    end

    # Install
    Dir.chdir "build" do
      system "make", "install"
    end

    man1.install "doc/_build/man/boolector.1"
    (share/"boolector").install "examples"
  end
end
