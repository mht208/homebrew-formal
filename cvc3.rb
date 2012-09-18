require 'formula'

class Cvc3 < Formula
  homepage 'http://www.cs.nyu.edu/acsys/cvc3/'
  url 'http://www.cs.nyu.edu/acsys/cvc3/releases/2.4.1/cvc3-2.4.1.tar.gz'
  sha1 'b694d65234fe1119d86f3c6f53318b09f0ad68fe'

  option 'with-zchaff', 'Build with zChaff'
  option 'with-gmp', 'Build with GMP'
  option 'with-static', 'Build static linked binaries'
  option 'with-debug', 'Build debug version'
  option 'with-java', 'Build with Java support'

  #depends_on :flex
  #depends_on :bison
  #depends_on :python
  depends_on 'gmp' if build.include? 'with-gmp'

  def install
    if build.include? 'with-static' and build.include? 'with-java'
      fail 'The Java interface requires a dynamic library build.'
    end

    ENV['CXX'] = 'g++'
    ENV.O2
    args = ["--prefix=#{prefix}"]
    args << ((build.include? 'with-zchaff') ? '--enable-zchaff' : '--disable-zchaff')
    args << ((build.include? 'with-gmp') ? '--with-arith=gmp' : '--with-arith=native')
    args << ((build.include? 'with-static') ? '--enable-static' : '--enable-dynamic')
    args << ((build.include? 'with-debug') ? '--with-build=debug' : '--with-build=optimized')
    if build.include? 'with-java'
      args << '--enable-java' << '--with-java-home=/System/Library/Frameworks/JavaVM.framework/Home' << '--with-java-includes=/System/Library/Frameworks/JavaVM.framework/Headers'
    else
      args << '--disable-java'
    end
    system "./configure", *args
    system "make install" # if this fails, try separate make/make install steps
  end
end
