require 'formula'

class Tuareg < Formula
  homepage 'https://github.com/ocaml/tuareg'
  url 'https://github.com/ocaml/tuareg/releases/download/2.0.8/tuareg-2.0.8.tar.gz'
  sha256 '13da95153d6d50ef697878c45d81302340f97a42ab14112c61b8c6b0e891512c'

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
