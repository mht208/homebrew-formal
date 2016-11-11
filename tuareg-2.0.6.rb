require 'formula'

class Tuareg206 < Formula
  homepage 'https://github.com/ocaml/tuareg'
  url 'http://forge.ocamlcore.org/frs/download.php/882/tuareg-2.0.6.tar.gz'
  sha256 'ea79ac24623b82ab8047345f8504abca557a537e639d16ce1ac3e5b27f5b1189'

  option 'with-emacs=', 'Re-compile the lisp files with a specified emacs'

  def which_emacs
    emacs = ARGV.value('with-emacs') || which('emacs').to_s
    raise "#{emacs} not found" unless File.exist? emacs
    return emacs
  end

  patch :DATA

  def install
    emacs = which_emacs
    ohai "Use #{emacs}"
    target = share/'emacs/site-lisp/tuareg'
    system "make EMACS=#{emacs}"
    target.install 'ocamldebug.elc', 'tuareg.elc'
    target.install 'ocamldebug.el', 'tuareg-pkg.el', 'tuareg-site-file.el', 'tuareg.el'
  end

  def caveats
    dir = "#{HOMEBREW_PREFIX}/share/emacs/site-lisp/tuareg"
    <<-EOS.undent
      Add the following line to ".emacs":
        (load "#{dir}/tuareg-site-file")
    EOS
  end
end

__END__

diff --git a/Makefile b/Makefile
index cd44f40..ecee44a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,9 +1,9 @@
 VERSION = $(shell grep ';; Version:' tuareg.el \
-	| sed 's/;; Version: *\([0-9.]\+\).*/\1/')
+	| sed 's/;; Version: *\([0-9.]*\).*/\1/')
 DESCRIPTION = $(shell grep ';;; tuareg.el ---' tuareg.el \
 	| sed 's/[^-]*--- *\(.*\)/\1/')
 REQUIREMENTS = $(shell grep ';; Package-Requires:' tuareg.el \
-	| sed 's/;; Package-Requires: *\(.\+\).*/\1/')
+	| sed 's/;; Package-Requires: *\(.*\).*/\1/')
 DIST_NAME = tuareg-$(VERSION)
 
 ELS = tuareg.el ocamldebug.el

