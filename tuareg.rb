require 'formula'

class Tuareg < Formula
  homepage 'https://github.com/ocaml/tuareg'
  url 'https://github.com/ocaml/tuareg/releases/download/2.0.8/tuareg-2.0.8.tar.gz'
  sha1 'a98f9ca9d592b5b8e0ca005006dd8c03265b2c0c'

  option 'with-emacs=', 'Re-compile the lisp files with a specified emacs'

  def which_emacs
    emacs = ARGV.value('with-emacs') || which('emacs').to_s
    raise "#{emacs} not found" unless File.exist? emacs
    return emacs
  end

  def install
    emacs = which_emacs
    ohai "Use #{emacs}"
    target = share/'emacs/site-lisp/tuareg'
    system "make EMACS=#{emacs}"
    target.install 'ocamldebug.elc', 'tuareg-site-file.elc', 'tuareg.elc'
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
