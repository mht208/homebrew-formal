require 'formula'

class AbcDownloadStrategy < CurlDownloadStrategy
  alias super_stage :stage
  def stage
    super_stage
    # Convert the format of abc_global.h to UNIX such that we can patch it.
    system "/usr/local/bin/dos2unix", "src/misc/util/abc_global.h"
  end
end

class Abc < Formula
  homepage 'http://www.eecs.berkeley.edu/~alanmi/abc/'
  url 'https://bitbucket.org/alanmi/abc/get/5f4f701.tar.gz', :using => AbcDownloadStrategy
  version '5f4f701'
  sha1 'e8a73787da783c87b6b8558b9e3409ce0adc1f73'

  depends_on 'dos2unix'

  def patches
    DATA
  end

  def install
    system "make"
    bin.install "abc"
    (share/'abc/scripts').install "abc.rc"
    ohai "The abc resource file has been installed to #{share}/abc/scripts/abc.rc. You may create a symbolic link ~/.abc.rc to the resource file such that alias commands can be used."
  end

end

__END__
diff --git a/Makefile b/Makefile
index 9c8a3a8..f2ffae2 100644
--- a/Makefile
+++ b/Makefile
@@ -63,7 +63,7 @@ endif
 
 endif
 
-LIBS := -ldl -lrt
+LIBS := -ldl
 
 ifneq ($(READLINE),0)
 CFLAGS += -DABC_USE_READLINE
diff --git a/src/misc/util/abc_global.h b/src/misc/util/abc_global.h
index 8952d1e..b1b9617 100644
--- a/src/misc/util/abc_global.h
+++ b/src/misc/util/abc_global.h
@@ -79,6 +79,9 @@
 #include <stdarg.h>
 #include <stdlib.h>
 
+#include <mach/task.h>
+#include <mach/mach.h>
+
 ////////////////////////////////////////////////////////////////////////
 ///                         NAMESPACES                               ///
 ////////////////////////////////////////////////////////////////////////
@@ -274,8 +277,11 @@ static inline abctime Abc_Clock()
 {
 #if defined(LIN) || defined(LIN64)
     struct timespec ts;
-    if ( clock_gettime(CLOCK_THREAD_CPUTIME_ID, &ts) < 0 ) 
-        return (abctime)-1;
+    struct task_thread_times_info aTaskInfo;
+    mach_msg_type_number_t aTaskInfoCount = TASK_THREAD_TIMES_INFO_COUNT;
+    assert(KERN_SUCCESS == task_info(mach_task_self(), TASK_THREAD_TIMES_INFO, (task_info_t )&aTaskInfo, &aTaskInfoCount));
+    ts.tv_sec = aTaskInfo.user_time.seconds;
+    ts.tv_nsec = aTaskInfo.user_time.microseconds * 1000;
     abctime res = ((abctime) ts.tv_sec) * CLOCKS_PER_SEC;
     res += (((abctime) ts.tv_nsec) * CLOCKS_PER_SEC) / 1000000000;
     return res;

