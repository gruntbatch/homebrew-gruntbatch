# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Feedline < Formula
  desc ""
  homepage ""
  url "https://codeload.github.com/gruntbatch/feedline/tar.gz/refs/tags/v0.9.1"
  sha256 "dae98add3e63a97ff1538baa90e15969db2db99f0548e2af76ae227e9686cb6d"
  license ""

  depends_on "go" => :build

  def install
    bin.mkpath
    ENV["GOBIN"] = bin

    system "go", "install", "-ldflags", "-s -w -X main.version=#{version}", "./..."

    libexec.mkpath
    system "cp", "-r", "web", libexec
  end

  service do
    run [opt_bin/"feedline", "-webdir", libexec/"web", "-addr", "localhost:8579", "-interval", "60m"]
    keep_alive true
    log_path "/tmp/feedline.stdout.log"
    error_log_path "/tmp/feedline.stderr.log"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test feedline`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
