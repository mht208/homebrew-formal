require 'formula'

class Automaton < Formula
  homepage 'http://www.brics.dk/automaton/'
  url 'http://www.brics.dk/~amoeller/automaton/automaton-1.11-8.tar.gz'
  sha256 '0a43f236cf59584ac4b2e9464c067458eae9a10899116e5c485944733976a1c0'

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
