require 'formula'

class Automaton < Formula
  homepage 'http://www.brics.dk/automaton/'
  url 'https://www.brics.dk/automaton/automaton-1.12-4.tar.gz'
  sha256 '48da157494429efe487dba4047240e60e622e7df2194ffe3eadf38fa93b46f18'

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
