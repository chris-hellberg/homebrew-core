class Iodine < Formula
  desc "Tunnel IPv4 traffic through a DNS server"
  homepage "https://code.kryo.se/iodine"
  url "https://github.com/yarrick/iodine/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "7281e2301804e48029877bab27134f7c0eb04567da4d21a6fcbaa7265cb5849e"
  license "ISC"
  head "https://github.com/yarrick/iodine.git", branch: "master"
  depends_on "cmake" => :build

  def install
    system "make"
    bin.install "bin/iodine"
    bin.install "bin/iodined"
    man8.install "man/iodine.8"
  end

  test do
    system "#{bin}/iodine", "-h"
    system "#{bin}/iodined", "-h"
  end
end
