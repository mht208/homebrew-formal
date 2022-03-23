require 'formula'

class Cvc5 < Formula
  homepage 'https://cvc5.github.io'
  desc 'CVC5 is an efficient open-source automatic theorem prover for satisfiability modulo theories (SMT) problems.'
  url 'https://github.com/cvc5/cvc5/releases/latest/download/cvc5-macOS'
  sha256 '224f3562eb1af44b13d7d6a284d1136efcdf32d0636274703654c95fbc035cdf'
  version '0.0.7'

  def install
    bin.install "cvc5-macOS" => "cvc5"
  end
end
