require 'formula'

class Z3 < Formula
  homepage 'https://github.com/Z3Prover/z3'
  url 'https://github.com/Z3Prover/z3/archive/z3-4.4.0.tar.gz'
  sha256 '65b72f9eb0af50949e504b47080fb3fc95f11c435633041d9a534473f3142cba'

  option 'with-ocaml', 'Build ocaml bindings with the ocaml from Homebrew.'
  option 'with-opam', 'Build ocaml bindings with the ocaml from OPAM.'

  depends_on 'autoconf' => :build
  depends_on :'python'

  def opam_env()
    old_env = `printenv`
    old_env = old_env.split(/\n/).map {|l| l.split(/=/)}

    opam_env = `#{HOMEBREW_PREFIX}/bin/opam config env`
    new_env = `eval "#{opam_env}"; printenv`
    new_env = new_env.split(/\n/).map {|l| l.split(/=/)}

    opam_env = Hash[ new_env - old_env ]
    opam_env.each {|k,v| ENV[k] = v }
  end

  def install
    # Load environment variables from OPAM
    if build.with? 'opam'
      opam_env()
    end

    # Check if ocaml and ocamlfind are available.
    if build.with? 'ocaml' or build.with? 'opam' then
      error = false
      begin
        system "ocamlc -where > /dev/null"
      rescue
        error = true
        onoe <<-EOS.undent
          Failed to find ocaml. You may run
            brew install ocaml
          or use OPAM to install it. For more information about OPAM, please see
            https://opam.ocaml.org
          for more information.
        EOS
      end
      begin
        system "ocamlfind printconf > /dev/null"
      rescue
        error = true
        onoe <<-EOS.undent
          Failed to find ocamlfind. You may run
            brew install ocaml-findlib
          to install it. If you use OPAM, you may run
            opam install ocamlfind
          to install it.
        EOS
      end

      if error then
        raise "Error found."
      end
    end

    # Fix the installation path of python bindings.
    inreplace 'scripts/mk_util.py', 'dist-packages', 'site-packages'

    # Generate makefiles.
    args = ['scripts/mk_make.py', "--prefix=#{prefix}"]
    if build.with? 'ocaml' or build.with? 'opam' then
      args << '--ml'
    end
    system "python", *args

    # Fix the installation path of ocaml bindings.
    prefix_stdlib = ""
    if build.with? 'ocaml' then
      homebrew_prefix_stdlib = `ocamlc -where`.gsub /\n/, ""
      prefix_stdlib = homebrew_prefix_stdlib.gsub HOMEBREW_PREFIX, prefix
    else
      prefix_stdlib = "#{prefix}/lib/ocaml"
    end
    if build.with? 'ocaml' or build.with? 'opam' then
      inreplace "build/Makefile", "ocamlfind install", "ocamlfind install -destdir #{prefix_stdlib}"

      # The ocaml library directory should be created before the installaion
      # by ocamlfind.
      mkdir_p "#{prefix_stdlib}"
    end

    # Build.
    Dir.chdir "build" do
      system "make"
      system "make PREFIX=#{prefix} install"
    end

    if build.with? 'opam' then
      findlibconf = `ocamlfind printconf conf`.chomp
      ohai <<-EOS.undent
        Please make sure that the installation path
          #{HOMEBREW_PREFIX}/lib/ocaml
        of ocaml bindings is added to the configuration file
          #{findlibconf}
        of ocamlfind.
      EOS
    end
  end
end
