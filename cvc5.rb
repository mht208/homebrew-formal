require 'formula'

class Cvc5 < Formula
  homepage 'https://cvc5.github.io'
  desc 'CVC5 is an efficient open-source automatic theorem prover for satisfiability modulo theories (SMT) problems.'
  url 'https://github.com/cvc5/cvc5/releases/download/cvc5-1.0.0/cvc5-macOS'
  sha256 '43420009f1b305f74d3c92aaf64ff3ce39e85e8601d4b0dc6c7dc33fe7c5be6d'
  version '1.0.0'

  def install
    bin.install "cvc5-macOS" => "cvc5"
  end
end
