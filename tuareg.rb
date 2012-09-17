require 'formula'

class Tuareg < Formula
  homepage 'http://tuareg.forge.ocamlcore.org'
  url 'https://forge.ocamlcore.org/frs/download.php/882/tuareg-2.0.6.tar.gz'
  sha1 '8cddbba69c4b73a3a9f2e352e4bc1f72b19a34b2'

  option 'with-emacs=</path/to/emacs>', 'Re-compile the lisp files with a specified emacs'

  def which_emacs
    ARGV.each do |a|
      if a.index('--with-emacs')
        emacs = a.sub('--with-emacs=', '')
        raise "#{emacs} not found" if not File.exists? "#{emacs}"
        ohai "Use Emacs: #{emacs}"
        return emacs
      end
    end
    return ""
  end

  def patches
    # Fix the retrival of tuareg version.
    DATA
  end

  def install
    emacs = which_emacs
    target = share/'emacs/site-lisp/tuareg'
    if emacs != ""
      system "make EMACS=#{emacs}"
      target.install 'ocamldebug.elc', 'tuareg-site-file.el', 'tuareg.elc'
    end
    target.install 'ocamldebug.el', 'tuareg-pkg.el', 'tuareg.el'
  end

  def caveats
    dir = "#{HOMEBREW_PREFIX}/share/emacs/site-lisp/tuareg"
    if which_emacs != ""
      <<-EOS.undent
        Please add the following line to your ".emacs":
          (load "#{dir}/tuareg-site-file.el")
      EOS
    else
      <<-EOS.undent
        Please add the following lines to your ".emacs":
          (add-to-list 'load-path "#{dir}")
          (setq auto-mode-alist
            (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
          (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code." t)
          (autoload 'camldebug "cameldeb" "Run the Caml debugger." t)
      EOS
    end
  end
end


__END__
diff --git a/Makefile b/Makefile
index cd44f40..de24ddc 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 VERSION = $(shell grep ';; Version:' tuareg.el \
-	| sed 's/;; Version: *\([0-9.]\+\).*/\1/')
+	| sed -E -e 's/;; Version: *([0-9.]+).*/\1/')
 DESCRIPTION = $(shell grep ';;; tuareg.el ---' tuareg.el \
 	| sed 's/[^-]*--- *\(.*\)/\1/')
 REQUIREMENTS = $(shell grep ';; Package-Requires:' tuareg.el \

