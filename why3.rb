require 'formula'

class Why3 < Formula
  homepage 'http://why3.lri.fr'
  url 'https://gforge.inria.fr/frs/download.php/31257/why3-0.73.tar.gz'
  sha1 '846021eb4a6b4e70c20902594a6399dcc3c026ce'

  option 'without-native', 'Build without the native OCaml compiler'
  option 'with-doc', 'Install documentations'
  option 'with-ide', 'Install IDE'

  depends_on 'objective-caml'
  depends_on 'coq' if build.include? 'with-coq'
  depends_on 'lablgtk2' if build.include? 'with-ide'

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    # The current version does not support Coq-8.4 and PVS
    args = ["--prefix=#{prefix}",
            "--disable-bench",
            "--enable-hypothesis-selection",
            "--disable-debug",
            "--disable-profiling",
            "--disable-pvs-libs",
            "--disable-coq-plugin", "--disable-coq-libs"]
    args << ((build.include? 'without-native') ? '--disable-native-code' : '--enable-native-code')
    args << ((build.include? 'with-doc') ? '--enable-doc' : '--disable-doc')
    system "./configure", *args

    # Fix a bug
    if build.include? 'without-native'
      chmod 0644, 'Makefile'
      inreplace 'Makefile', /OCAMLOPT *= no/, 'OCAMLOPT = true'
    end

    system "make"
    system "make byte"
    system "make install OCAMLLIB=#{prefix_stdlib}"
    system "make install-lib OCAMLLIB=#{prefix_stdlib}"
  end
end
