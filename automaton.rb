require 'formula'

class Automaton < Formula
  homepage 'http://www.brics.dk/automaton/'
  url 'http://www.brics.dk/~amoeller/automaton/automaton-1.11-8.tar.gz'
  sha1 'd17faa6d3c5c93be75b52984c83fee4a48ec91b6'

  option 'with-doc', 'Install documentation'

  depends_on 'ant'

  def install
    system "ant"
    mv "dist/automaton.jar", "dist/automaton-#{version}.jar"
    (share/'java').install "dist/automaton-#{version}.jar"
    ln_s "#{share}/java/automaton-#{version}.jar", "#{share}/java/automaton.jar"
    ohai "The automaton package is installed in #{HOMEBREW_PREFIX}/share/java/automaton.jar."

    if build.with? 'doc'
      (share/'doc'/'automaton').install Dir["doc/*"]
      ohai "The documentation is installed in #{HOMEBREW_PREFIX}/share/doc/automaton/."
    end
  end
end
