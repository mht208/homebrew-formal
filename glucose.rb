require 'formula'

class Glucose < Formula
  desc 'The Glucose SAT Solver'
  homepage 'http://www.labri.fr/perso/lsimon/glucose/'
  url 'http://www.labri.fr/perso/lsimon/downloads/softwares/glucose-syrup-4.1.tgz'
  sha256 '51aa1cf1bed2b14f1543b099e85a56dd1a92be37e6e3eb0c4a1fd883d5cc5029'

  patch :DATA

  def install
    Dir.chdir 'parallel' do
      system 'make r'
    end
    Dir.chdir 'simp' do
      system 'make r'
    end
    bin.install 'parallel/glucose-syrup_release' => 'glucose-syrup'
    bin.install 'simp/glucose_release' => 'glucose'
  end

end
