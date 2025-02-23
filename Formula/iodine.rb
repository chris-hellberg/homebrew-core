class Iodine < Formula
  desc "Tunnel IPv4 traffic through a DNS server"
  homepage "https://code.kryo.se/iodine"
  url "https://github.com/yarrick/iodine/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "7281e2301804e48029877bab27134f7c0eb04567da4d21a6fcbaa7265cb5849e"
  license "ISC"
  head "https://github.com/yarrick/iodine.git", branch: "master"

  depends_on "cmake" => :build

  uses_from_macos "zlib"

  def install
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    # iodine and iodined require being run as root. Match on the non-root error text, which is printed to
    # stderr, as a successful test
    assert_match("iodine: Run as root and you'll be happy.", pipe_output("#{sbin}/iodine google.com 2>&1"))
    assert_match("iodined: Run as root and you'll be happy.", pipe_output("#{sbin}/iodined google.com 2>&1"))
  end
end
