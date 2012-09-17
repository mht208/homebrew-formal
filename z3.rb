require 'formula'

class Z3 < Formula
  homepage 'http://research.microsoft.com/en-us/um/redmond/projects/z3/'
  url 'http://research.microsoft.com/en-us/um/redmond/projects/z3/z3-osx-4.1-x64.tar.gz'
  version '4.1'
  sha1 '80d68d08e15ec40ba314c226f065b2def550fca4'

  option 'with-ocaml', 'Build OCaml libraries'

  if build.include? 'with-ocaml'
    depends_on 'objective-caml'
    depends_on 'camlidl'
  end

  def install
    if build.include? 'with-ocaml'
      homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
      prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix
      Dir.chdir 'ocaml' do
        system "./build-lib.sh #{homebrew_prefix_stdlib}"
        mkdir_p "#{prefix_stdlib}/z3"
        cp %w(libz3stubs.a z3.a z3.cmi z3.cmx z3.cmxa z3.mli), "#{prefix_stdlib}/z3"
      end
    end
    bin.install "bin/z3"
    (include/'z3').install (Dir.glob "include/*.h")
    lib.install (Dir.glob "lib/libz3*")
    (share/'z3').install ["examples", "python"]
  end
end
