require 'formula'

class Nusmv < Formula
  homepage 'http://nusmv.fbk.eu'
  url 'http://nusmv.fbk.eu/distrib/NuSMV-2.5.4.tar.gz'
  sha1 '968798a95eac0127e3324dd2dc05bc0ff3ccf2fd'

  option 'with-zchaff', 'Build with zchaff'

  depends_on 'wget'
  if build.include? "with-zchaff"
    depends_on 'zchaff'
  end

  def install
    ENV.j1

    ohai 'Compile CUDD'
    Dir.chdir 'cudd-2.4.1.1' do
      system "make -f Makefile_os_x_64bit"
    end

    ohai 'Compile MiniSat'
    Dir.chdir 'MiniSat' do
      ENV['CXX'] = "g++"
      system 'sh build.sh'
    end

    ohai 'Compile NuSMV'
    Dir.chdir 'nusmv' do
      args = ["--disable-debug",
              "--disable-dependency-tracking",
              "--prefix=#{prefix}",
              "--enable-minisat",
              "--with-minisat-libdir=../MiniSat/minisat",
              "--with-minisat-incdir=../MiniSat/minisat"]
      if build.include? 'with-zchaff'
        args << ["--enable-zchaff",
                 "--with-zchaff-libdir=#{HOMEBREW_PREFIX}/lib/zchaff",
                 "--with-zchaff-incdir=#{HOMEBREW_PREFIX}/include/zchaff"]
      end
      system "./configure", *args
      system 'make'
      system 'make install'
    end
  end

end
