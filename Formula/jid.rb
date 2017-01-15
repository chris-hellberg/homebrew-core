require "language/go"

class Jid < Formula
  desc "Json incremental digger"
  homepage "https://github.com/simeji/jid"
  url "https://github.com/simeji/jid/archive/0.7.1.tar.gz"
  sha256 "4d641a2df2fbdc90f28b727782f08573024c712178e3ef373eda2dbc014d482a"

  bottle do
    cellar :any_skip_relocation
    sha256 "614f4123c9e8891ba1c30c0fbf047214316ff881d7e964a8568d5858ee4e4e5a" => :sierra
    sha256 "25930dbf57b59917534a4bb93dfa45f051e3864f3063d474859ecae122146be9" => :el_capitan
    sha256 "6e7a89947c15d691e622f2dd637876c21639996df4565c86cff10fdf1d2cca03" => :yosemite
  end

  depends_on "go" => :build

  go_resource "github.com/bitly/go-simplejson" do
    url "https://github.com/bitly/go-simplejson.git",
        :revision => "aabad6e819789e569bd6aabf444c935aa9ba1e44"
  end

  go_resource "github.com/fatih/color" do
    url "https://github.com/fatih/color.git",
        :revision => "42c364ba490082e4815b5222728711b3440603eb"
  end

  go_resource "github.com/mattn/go-colorable" do
    url "https://github.com/mattn/go-colorable.git",
        :revision => "d228849504861217f796da67fae4f6e347643f15"
  end

  go_resource "github.com/mattn/go-isatty" do
    url "https://github.com/mattn/go-isatty.git",
        :revision => "30a891c33c7cde7b02a981314b4228ec99380cca"
  end

  go_resource "github.com/mattn/go-runewidth" do
    url "https://github.com/mattn/go-runewidth.git",
        :revision => "737072b4e32b7a5018b4a7125da8d12de90e8045"
  end

  go_resource "github.com/nsf/termbox-go" do
    url "https://github.com/nsf/termbox-go.git",
        :revision => "abe82ce5fb7a42fbd6784a5ceb71aff977e09ed8"
  end

  go_resource "github.com/nwidger/jsoncolor" do
    url "https://github.com/nwidger/jsoncolor.git",
        :revision => "0192e84d44af834c3a90c8a17bf670483b91ad5a"
  end

  go_resource "github.com/pkg/errors" do
    url "https://github.com/pkg/errors.git",
        :revision => "248dadf4e9068a0b3e79f02ed0a610d935de5302"
  end

  def install
    ENV["GOPATH"] = buildpath

    # Fix version
    # Reported 14 Jan 2017 https://github.com/simeji/jid/issues/57
    inreplace "cmd/jid/jid.go", "VERSION = \"0.6.2\"",
                                "VERSION = \"#{version}\""

    (buildpath/"src/github.com/simeji").mkpath
    ln_sf buildpath, buildpath/"src/github.com/simeji/jid"
    Language::Go.stage_deps resources, buildpath/"src"
    system "go", "build", "-o", bin/"jid", "cmd/jid/jid.go"
  end

  test do
    assert_match "jid version v#{version}", shell_output("#{bin}/jid --version")
  end
end
