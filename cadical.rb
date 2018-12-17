require 'formula'

class Cadical < Formula
  homepage 'https://github.com/arminbiere/cadical'
  url 'https://github.com/arminbiere/cadical/archive/sc18.tar.gz'
  sha256 'cac42428f6562ab5000bc7e74da3ce503a43f6653df542433bf150000d022096'
  desc 'a SAT solver'

  def install
    system './configure'
    system 'make'
    bin.install 'build/cadical'
  end

end
