require 'formula'

class Strix < Formula
  desc 'a tool for reactive synthesis of controllers from LTL specifications'
  homepage 'https://github.com/meyerphi/strix'
  url 'https://github.com/meyerphi/strix/releases/download/21.0.0/strix-21.0.0-1-x86_64-macos.tar.gz'
  sha256 'a430e203482026cd20f2b93b9be2e8964eaf433ffbe80dbe83412ceed4a7b313'
  version '21.0.0'

  def install
    bin.install "strix"
  end
end
