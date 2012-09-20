require 'formula'

class Coqide < Formula
  homepage 'http://coq.inria.fr/'
  url 'http://coq.inria.fr/distrib/V8.4/files/coq-8.4.tar.gz'
  sha1 '2987aa418dd96a0df7284afe296293cb28814ef5'

  option 'with-opt', 'Build native binaries'

  depends_on 'coq'
  depends_on 'lablgtk2'

  def patches
    # Fix coqide compilation with lablgtk 2.16.
    "https://github.com/coq/coq/commit/f0b936e7cb90000f5db6272b926cb13dc1a5c055.patch"
#    DATA
  end

  def install
    args = ["-prefix", prefix,
            "-mandir", man,
            "-coqdocdir", "#{share}/coq/latex",
            "-with-doc", "no"]
    args << "-coqide" << ((build.include? 'with-opt') ? 'opt' : 'byte')
    system "./configure", *args
    system "make coqide"
    system "make install-coqide"
  end
end


__END__
diff --git a/Makefile.build b/Makefile.build
index fe99f3b..1ac99f5 100644
--- a/Makefile.build
+++ b/Makefile.build
@@ -304,7 +304,7 @@ plugins/micromega/csdpcert$(EXE): $(CSDPCERTCMO:.cmo=$(BESTOBJ))
 .PHONY: coqide coqide-binaries coqide-no coqide-byte coqide-opt coqide-files
 
 # target to build CoqIde
-coqide:: coqide-files coqide-binaries states
+coqide:: coqide-files coqide-binaries theories/Init/Prelude.vo
 
 COQIDEFLAGS=-thread $(COQIDEINCLUDES)
 
diff --git a/ide/preferences.ml b/ide/preferences.ml
index 17216b9..2fb5023 100644
--- a/ide/preferences.ml
+++ b/ide/preferences.ml
@@ -35,6 +35,10 @@ let mod_to_str (m:Gdk.Tags.modifier) =
     | `MOD5 -> "<Mod5>"
     | `CONTROL -> "<Control>"
     | `SHIFT -> "<Shift>"
+    | `HYPER -> "<Hyper>"
+    | `META -> "<Meta>"
+    | `RELEASE -> ""
+    | `SUPER -> "<Super>"
     |  `BUTTON1| `BUTTON2| `BUTTON3| `BUTTON4| `BUTTON5| `LOCK -> ""
 
 let mod_list_to_str l = List.fold_left (fun s m -> (mod_to_str m)^s) "" l
diff --git a/ide/utils/okey.ml b/ide/utils/okey.ml
index 5793926..74831db 100644
--- a/ide/utils/okey.ml
+++ b/ide/utils/okey.ml
@@ -47,6 +47,10 @@ let int_of_modifier = function
   | `BUTTON3 -> 1024
   | `BUTTON4 -> 2048
   | `BUTTON5 -> 4096
+  | `HYPER -> 1 lsl 22
+  | `META -> 1 lsl 20
+  | `RELEASE -> 1 lsl 30
+  | `SUPER -> 1 lsl 21
 
 let print_modifier l =
   List.iter
@@ -65,7 +69,11 @@ let print_modifier l =
 	  | `BUTTON2 -> "B2"
 	  | `BUTTON3 -> "B3"
 	  | `BUTTON4 -> "B4"
-	  | `BUTTON5 -> "B5")
+	  | `BUTTON5 -> "B5"
+          | `HYPER -> "HYPER"
+	  | `META -> "META"
+	  | `RELEASE -> ""
+	  | `SUPER -> "SUPER")
 	    m)^" ")
     )
     l;

