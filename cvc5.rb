class Cvc5 < Formula
  desc "Efficient open-source automatic theorem prover for SMT problems"
  homepage "https://cvc5.github.io"
  version "1.0.1"

  # frozen_string_literal: true
  #
  if Hardware::CPU.intel?
    url "https://github.com/cvc5/cvc5/releases/download/cvc5-1.0.1/cvc5-macOS"
    sha256 "67c32310226177ec36d60d377f31eea211c2543bd6487b5c39c39bf9547df568"
  else
    url "https://github.com/cvc5/cvc5/releases/download/cvc5-1.0.1/cvc5-macOS-arm64"
    sha256 "89b9df4307ff6401c3487b1df166ea77eb7f91b8fd91d52376a1b7660f5930ba"
  end

  def install
    if Hardware::CPU.intel?
      bin.install "cvc5-macOS" => "cvc5"
    else
      bin.install "cvc5-macOS-arm64" => "cvc5"
    end
  end
end
