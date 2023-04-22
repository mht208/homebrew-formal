require 'formula'

class Prism < Formula
  homepage 'http://www.prismmodelchecker.org'
  url 'https://github.com/prismmodelchecker/prism/archive/refs/tags/v4.7.tar.gz'
  sha256 '16186047ba49efc6532de6e9c3993c8c73841a7c76c99758d6ee769e72092d6d'
  version '4.7'

  patch :DATA

  def install
    Dir.chdir "prism" do
      system "OSTYPE=darwin make release"
      Dir.chdir "release" do
        Dir["prism-*.tar.gz"].each do |tgz|
          system "tar zxf #{tgz}"
          Dir.chdir tgz.sub(".tar.gz", "") do
            (share/"prism").install Dir["*"]
          end
        end
      end
    end
    Dir.chdir "#{share}/prism" do
      system "./install.sh"
    end
    mkdir "#{bin}"
    ln_s "#{share}/prism/bin/prism", "#{bin}/prism"
    ln_s "#{share}/prism/bin/xprism", "#{bin}/xprism"
    ohai "The PRISM package is installed in #{HOMEBREW_PREFIX}/share/prism."
  end
end

__END__
diff --git a/cudd/util/util.h b/cudd/util/util.h
index 1914672..eddfeb4 100644
--- a/cudd/util/util.h
+++ b/cudd/util/util.h
@@ -166,7 +166,7 @@ extern int memcmp(), strcmp();
 #endif
 
 
-#define fail(why) {\
+#define cuddfail(why) {\
     (void) fprintf(stderr, "Fatal error: file %s, line %d\n%s\n",\
 	__FILE__, __LINE__, why);\
     (void) fflush(stdout);\

