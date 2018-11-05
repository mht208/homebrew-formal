require 'formula'

class Boolector < Formula
  desc 'an SMT solver'
  homepage 'http://fmv.jku.at/boolector/'
  url 'https://github.com/Boolector/boolector/archive/3.0.0.tar.gz'
  sha256 '1db846f73643059a8bf533efd6c306c7d20c161dfe185b07923dc35b1f35a513'

  option 'with-doc', 'Install documentation'
  option 'without-python', 'Do not install python API (because it seems not working)'

  depends_on 'cmake'
  depends_on 'sphinx-doc' if build.with? 'doc'

  def install
    # Build dependencies
    system "./contrib/setup-btor2tools.sh"
    system "./contrib/setup-cadical.sh"
    system "./contrib/setup-lingeling.sh"
    #system "./contrib/setup-minisat.sh" # Failed to compile
    #system "./contrib/setup-picosat.sh" # Failed to compile

    args = []
    args << ((build.with? 'python') ? '--python' : '')

    # Configure Boolector
    system "./configure.sh", *args

    # Compile Boolector
    Dir.chdir 'build' do
      if build.with? 'python' then
        Dir.chdir 'src/api/python' do
          system "make pyboolector_options"
        end
      end
      system "make"
    end

    if build.with? 'doc' then
      Dir.chdir 'doc' do
        system "make html"
        system "make man"
      end
    end

    # Install
    Dir.chdir 'build' do
      bin.install "bin/boolector", "bin/btorimc", "bin/btormbt",
                  "bin/btormc", "bin/btoruntrace"
      lib.install "lib/libboolector.a"
      lib.install "lib/pyboolector.so" if build.with? 'python'
    end
    Dir.chdir 'src' do
      (include/'boolector').install Dir['*.h']
      (include/'boolector'/'dumper').install Dir['dumper/*.h']
      (include/'boolector'/'parser').install Dir['parser/*.h']
      (include/'boolector'/'simplifier').install Dir['simplifier/*.h']
      (include/'boolector'/'utils').install Dir['utils/*.h']
    end
    if build.with? 'doc' then
      (share/'boolector').install 'doc/_build/html'
      man1.install 'doc/_build/man/boolector.1'
    end
    (share/'boolector').install 'examples'
  end

end
