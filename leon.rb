require 'formula'

class Leon < Formula
  homepage 'https://leon.epfl.ch'
  url 'https://github.com/epfl-lara/leon.git', :revision => "90bfec6dff7c8e09cc493aeb028c627b4ca78c4e"
  version '3.0'

  depends_on 'sbt'
  depends_on 'z3'

  def install
    scala_version = `#{HOMEBREW_PREFIX}/bin/scala -version 2>&1 | awk '{print $5}' | cut -d "." -f 1 -f 2`
    scala_version = scala_version.strip

    (lib/"leon").install "library"
    inreplace "build.sbt", 'baseDirectory.value / "library"', "file(\"#{lib}/leon\") / \"library\""

    system "sbt clean compile"
    system "sbt script"

    (lib/"leon/target/scala-#{scala_version}").install ("target/scala-#{scala_version}/classes")
    (lib/'leon/src/main').install ("src/main/resources")
    (lib/'leon/unmanaged/64').install Dir["unmanaged/64/*.jar"],
                                      Dir["unmanaged/common/*.jar"]
    inreplace 'leon', "#{buildpath}", "#{lib}/leon"
    bin.install 'leon'
  end
end
