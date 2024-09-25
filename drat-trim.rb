require 'formula'

class DratTrim < Formula
  desc 'Check whether a propositional formula in the DIMACS format is unsatisfiable'
  homepage 'https://github.com/marijnheule/drat-trim'
  head 'https://github.com/marijnheule/drat-trim', :using => :git, :revision => 'cbd2915'
  version 'cbd2915'

  def install
    system 'make'
    bin.install 'drat-trim'
  end

end
