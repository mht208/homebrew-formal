require 'formula'

class Z3 < Formula
  homepage 'http://z3.codeplex.com'
  url 'https://git.codeplex.com/z3', :using => :git, :tag => 'v4.3.2', :revision => 'cee7dd39444c9060186df79c2a2c7f8845de415b'
  sha1 'cbfbec39c1c671a932bfd86ff34aebd0f5a4b7aa'

  depends_on 'autoconf' => :build
  depends_on :'python'

  def install
    inreplace "scripts/mk_util.py", "dist-packages", "site-packages"
    system "python scripts/mk_make.py --prefix=#{prefix}"

    Dir.chdir "build" do
      system "make"
      system "make PREFIX=#{prefix} install"
    end
  end
end
