class Cvc5 < Formula
  desc "Efficient open-source automatic theorem prover for SMT problems"
  homepage "https://cvc5.github.io"
  version "1.3.0"

  depends_on 'gmp'
  depends_on 'cadical'

  # frozen_string_literal: true
  #
  if Hardware::CPU.intel?
    url "https://github.com/cvc5/cvc5/releases/download/cvc5-1.3.0/cvc5-macOS-x86_64-static.zip"
    sha256 "9bd61fbabd4786aca0c1bb63758fef56032b7e45a87880638073ec3cee7e6b2d"
  else
    url "https://github.com/cvc5/cvc5/releases/download/cvc5-1.3.0/cvc5-macOS-arm64-static.zip"
    sha256 "eb3c1a75efe28a7be7d05c4dd45846f0a7ab5cd1fcb7fb6987ebcac9164037bf"
  end

  def install
    if Hardware::CPU.intel?
      bin.install "bin/cvc5"
      include.install "include/cvc5"
      lib.install "lib/libcvc5.a", "lib/libcvc5jni.dylib", "lib/libcvc5parser.a", "lib/libpicpoly.a", "lib/libpicpolyxx.a"
      share.install Dir["share/*"]
    else
      bin.install "bin/cvc5"
      include.install "include/cvc5"
      lib.install "lib/cmake"
      lib.install "lib/libcvc5.a", "lib/libcvc5jni.dylib", "lib/libcvc5parser.a", "lib/libpicpoly.a", "lib/libpicpolyxx.a"
      share.install Dir["share/*"]
    end
  end
end
