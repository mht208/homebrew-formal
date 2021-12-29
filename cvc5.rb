require 'formula'

class Cvc5 < Formula
  include Language::Python::Virtualenv

  homepage 'https://cvc5.github.io'
  url 'https://github.com/cvc5/cvc5/archive/refs/tags/cvc5-0.0.4.tar.gz'
  sha256 '8c7eb6d4b372917f82c7a0889ae4ace05229e82e8afd31d1a9c79ed7db7d079b'

  depends_on "coreutils" => :build
  depends_on "cmake" => :build
  depends_on "python@3.9"
  depends_on "gmp" => :build
  depends_on "cadical"

  def install
    args = [ "--prefix=#{prefix}",
             "--auto-download" ]
    system "./configure.sh", *args
    chdir "build" do
      system "make"
      system "make", "install"
    end
  end
end
