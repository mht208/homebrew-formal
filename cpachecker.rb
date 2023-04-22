require 'formula'

class Cpachecker < Formula
  desc 'CPAchecker is a tool for configurable software verification.'
  homepage 'http://cpachecker.sosy-lab.org'
  url 'https://svn.sosy-lab.org/software/cpachecker/tags/cpachecker-2.2',
        using: :svn

  patch :DATA

  depends_on 'ant'

  def install
    File.open("cpachecker", "w") { |f|
      f.puts("#!/bin/sh\n")
      f.puts((share/'cpachecker').to_s << "/scripts/cpa.sh \"$@\"")
    }
    File.chmod(0755, "cpachecker")
    system "ant jar"
    bin.install "cpachecker"
    (share/'cpachecker').install "LICENSE", "NEWS.md", "README.md", "config",
                                 "contrib", "cpachecker.jar", "doc", "lib",
                                 "scripts"
  end
end

__END__
diff --git a/build/build-compile.xml b/build/build-compile.xml
index d8747dc..283ef0e 100644
--- a/build/build-compile.xml
+++ b/build/build-compile.xml
@@ -73,7 +73,6 @@ SPDX-License-Identifier: Apache-2.0
             <compilerarg value="-Xlint:-fallthrough"/> <!-- checked by error-prone, too, and javac does not recognized $FALL-THROUGH$ -->
             <compilerarg value="-Xlint:-processing"/>
             <compilerarg value="-Xlint:-options"/> <!-- suppress warning about bootclasspath on newer JDK -->
-            <compilerarg value="-Werror" unless:set="compile.warn"/>
             <compilerarg line="${errorprone.options.required}" unless:set="errorprone.disable"/>
             <compilerarg value="-Xplugin:ErrorProne -XepDisableWarningsInGeneratedCode ${errorprone.options}" unless:set="errorprone.disable"/>
             <compilerarg value="-s"/><compilerarg value="${source.generated.dir}"/>

