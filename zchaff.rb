class Zchaff < Formula
  env :std
  desc "Implementation of the Chaff algorithm"
  homepage "http://www.princeton.edu/~chaff/zchaff.html"
  url "http://www.princeton.edu/~chaff/zchaff/zchaff.64bit.2007.3.12.zip"
  sha256 "9b88d8f366d0dc6b3cacd9d497e755d06af069ff27411870cc8b40fe0f11911f"

  option "with-extra", "Install extra utilities"

  def install
    ENV.deparallelize do
      system "make", "zchaff"
      if build.with? "extra"
        # Patch zverify_df.cpp so it can find getpid()
        system "sed -i '' '1i\\
        #include <unistd.h>' zverify_df.cpp"
        system "make", "all"
      end
      system "make", "SAT_C.h"
    end
    bin.install "zchaff"
    bin.install "cnf_stats", "zminimal", "zverify_df" if build.with? "extra"
    (include/"zchaff").install "SAT.h", "SAT_C.h"
    (lib/"zchaff").install "libsat.a"
  end
end
