class Cvc5 < Formula
  desc "Efficient open-source automatic theorem prover for SMT problems"
  homepage "https://cvc5.github.io"
  version "1.0.3"

  # frozen_string_literal: true
  #
  if Hardware::CPU.intel?
    url "https://github.com/cvc5/cvc5/releases/download/cvc5-1.0.3/cvc5-macOS"
    sha256 "dca671880681ab51e544eab015347f7568174418bb58a22cebe3cefc007120ac"
  else
    url "https://github.com/cvc5/cvc5/releases/download/cvc5-1.0.3/cvc5-macOS-arm64"
    sha256 "00b29781288f4fca797d0fda3edc887cbf8b07f857d0e45ef567b0e512002336"
  end

  def install
    if Hardware::CPU.intel?
      bin.install "cvc5-macOS" => "cvc5"
    else
      bin.install "cvc5-macOS-arm64" => "cvc5"
    end
  end
end
