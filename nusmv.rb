class Nusmv < Formula
  env :std
  desc "Software tool for the formal verification of finite state systems"
  homepage "http://nusmv.fbk.eu"
  url "https://nusmv.fbk.eu/distrib/NuSMV-2.6.0.tar.gz"
  sha256 "dba953ed6e69965a68cd4992f9cdac6c449a3d15bf60d200f704d3a02e4bbcbb"

  option "with-zchaff", "Build with zchaff support"

  depends_on "cmake" => :build
  depends_on "pyenv" => :build
  depends_on "zlib" => :build
  depends_on "mht208/formal/cudd"
  depends_on "wget"

  def install
    ohai "Install Python 2 with pyenv"
    with_env(
      CFLAGS:  "-I#{HOMEBREW_PREFIX}/opt/zlib/include",
      LDFLAGS: "-L#{HOMEBREW_PREFIX}/opt/zlib/lib",
    ) do
      system "pyenv", "install", "2.7.18", "-s"
    end
    python_path = `pyenv prefix 2.7.18`.chomp

    ohai "Compile NuSMV"
    Dir.chdir "nusmv" do
      mkdir_p "build"
      Dir.chdir "build" do
        args = ["..", "-DPYTHON_EXECUTABLE=#{python_path}/bin/python"]
        args.push("-DENABLE_ZCHAFF=ON") if build.with? "zchaff"
        system "cmake", *args

        if build.with? "zchaff"
          ENV.deparallelize do
            system "make"
          end
        else
          system "make"
        end
        Dir.chdir "bin" do
          bin.install "ltl2smv"
          bin.install "NuSMV"
        end
        Dir["lib/*.a"] { |f| lib.install f }
      end
    end
  end
end
