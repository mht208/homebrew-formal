require 'formula'

class Glucose < Formula
  desc 'The Glucose SAT Solver'
  homepage 'https://www.labri.fr/perso/lsimon/research/glucose/'
  url 'https://www.labri.fr/perso/lsimon/downloads/softwares/glucose-4.2.1.zip'
  sha256 '27427d10a0bfe1c0a266bff2e25cfe1e6ece726266308216cd0fb873e2a1a978'

  def install
    Dir.chdir 'sources' do
      Dir.chdir 'simp' do
        system 'make r'
      end
      Dir.chdir 'parallel' do
        system 'CFLAGS="-Wall -Wno-parentheses -std=c++11" make r'
      end
      bin.install 'simp/glucose_release' => 'glucose'
      bin.install 'parallel/glucose-syrup_release' => 'glucose-syrup'
    end
  end

end
