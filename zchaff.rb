require 'formula'

class Zchaff < Formula
  homepage 'http://www.princeton.edu/~chaff/zchaff.html'
  url 'http://www.princeton.edu/~chaff/zchaff/zchaff.64bit.2007.3.12.zip'
  sha1 '81770c7121c95686b8fda1f554063a946528ca28'

  option 'with-extra', 'Install extra utilities'

  def install
    ENV.j1
    if build.include? 'with-extra'
      system "make all"
    else
      system "make"
    end
    system "make SAT_C.h"
    bin.install "zchaff"
    bin.install "cnf_stats", "zminimal", "zverify_df" if build.include? 'with-extra'
    (include/'zchaff').install "SAT.h", "SAT_C.h"
    (lib/'zchaff').install "libsat.a"
  end

end
