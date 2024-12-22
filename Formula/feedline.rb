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
  
  def plist
    <<~EOS
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>Label</key>
            <string>#{plist_name}</string>
            <key>ProgramArguments</key>
            <array>
                <string>#{opt_bin}/feedline</string>
                <string>-webdir</string>
                <string>#{libexec}/web</string>
                <string>-addr</string>
                <string>localhost:8579</string>
                <string>-interval</string>
                <string>60m</string>
            </array>
            <key>RunAtLoad</key>
            <true />
            <key>KeepAlive</key>
            <true />
            <key>StandardErrorPath</key>
            <string>/tmp/#{plist_name}.stderr.log</string>
            <key>StandardOutPath</key>
            <string>/tmp/#{plist_name}.stdout.log</string>
        </dict>
    </plist>
    EOS
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
