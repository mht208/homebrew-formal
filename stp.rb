require 'formula'

class Stp < Formula
  homepage 'https://stp.github.io'
  url 'https://github.com/stp/stp/archive/2.3.3.tar.gz'
  sha256 'ea6115c0fc11312c797a4b7c4db8734afcfce4908d078f386616189e01b4fffa'
  head 'https://github.com/stp/stp.git', :branch => 'master'

  depends_on 'cmake' => :build
  depends_on 'bison'
  depends_on 'flex'
  depends_on 'minisat2'
  depends_on 'cryptominisat'

  def install
    pyver = `python --version 2>&1 | awk '{print $2}'`.chomp.gsub(/([0-9]+).([0-9]+).([0-9]+)/, '\1.\2')
    pylocal = (lib/"python#{pyver}/site-packages")
    Dir.mkdir "build"
    Dir.chdir "build" do
      mkdir_p "#{pylocal}"
      system "cmake -DCMAKE_INSTALL_PREFIX:PATH=#{prefix} -DPYTHON_LIB_INSTALL_DIR=#{pylocal} .."
      system "make"
      system "make install"
    end
  end
end
