require 'formula'

class Why3 < Formula
  homepage 'http://why3.lri.fr'
  url 'https://gforge.inria.fr/frs/download.php/file/34074/why3-0.85.tar.gz'
  sha256 'ee2aa4ae0d9ed5ccceadb9dd9c43d2c4c4f6e2d31eb9a0b5df76630a4abb416a'

  option 'without-native', 'Build without the native OCaml compiler'
  option 'with-doc', 'Install documentations'
  option 'with-ide', 'Install IDE'
  option 'with-coq-libs', 'Enable Coq realizations'
  option 'with-coq-tactic', 'Enable Coq "why3" tactic'
  option 'with-profiling', 'Enable profiling'
  option 'with-flocq', 'Enable floating point arithmetic'
  option 'with-gmp', 'Enable GMP arithmetic'

  depends_on 'objective-caml'
  depends_on 'coq' if build.with? 'coq-libs' or build.with? 'coq-tactics'
  depends_on 'lablgtk2' => 'with-gtksourceview2' if build.with? 'ide'
  depends_on 'gmp' if build.with? 'gmp' => :optional

  def install
    homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
    prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix

    # The current version does not support Coq-8.4 and PVS
    args = ["--prefix=#{prefix}",
            "--enable-hypothesis-selection",
            "--disable-debug",
            "--disable-pvs-libs"]
    args << ((build.without? 'native') ? '--disable-native-code' : '--enable-native-code')
    args << ((build.with? 'doc') ? '--enable-doc' : '--disable-doc')
    args << ((build.with? 'coq-libs') ? '--enable-coq-libs' : '--disable-coq-libs')
    args << ((build.with? 'coq-tactic') ? '--enable-coq-tactic' : '--disable-coq-tactic')
    args << ((build.with? 'profiling') ? '--enable-profiling' : '--disable-profiling')
    system "./configure", *args

    system "make"
    system "make byte"
    system "make install OCAMLLIB=#{prefix_stdlib}"
    system "make install-lib OCAMLLIB=#{prefix_stdlib}"
  end
end
