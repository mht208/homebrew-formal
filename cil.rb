require 'formula'

class Cil < Formula
  homepage 'http://kerneis.github.com/cil/'
  url 'http://downloads.sourceforge.net/project/cil/cil/cil-1.7.3.tar.gz'
  sha1 'c0605a8d5d3bc5748fdfed8584942b1ff72da01f'

  depends_on "objective-caml"
  depends_on "ocaml-findlib"

  option 'with-llvm', 'enable the LLVM code generator'

# Get an error message complaining circular dependencies if
# zrapp is enabled.
#  option 'with-zrapp', 'enable the zrapp pretty-printer'

# Get an error message complaining that Util.memorize is not found if
# blockinggraph is enabled.
# option 'with-blockinggraph', 'enable the blocking graph feature'

  def install
    ENV.j1
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    # Fix the installation path.
    inreplace "Makefile.in", "$(OCAMLFIND) install",
              "$(OCAMLFIND) install -destdir #{prefix_stdlib}"

    args =
    if build.with? 'llvm' then
      args = "#{args} --with-llvm"
    end

    system "./configure --prefix=#{prefix} FORCE_PERL_PREFIX=1 #{args}"
    system "make"

    # The ocaml library directory should be created before the installaion
    # by ocamlfind.
    mkdir_p "#{prefix_stdlib}"

    system "make install"
  end

end
