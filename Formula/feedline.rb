# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Feedline < Formula
  desc ""
  homepage ""
  url "https://github.com/gruntbatch/feedline/archive/v0.6.0.tar.gz"
  sha256 "84fc9e155820e2af8fef85cd8991947eda7341371eeacac97f078d5dae79e031"
  license ""

  depends_on "go" => :build

  def install
    bin.mkpath
    ENV["GOBIN"] = bin

    system "go", "install", "-ldflags", "-s -w -X main.version=#{version}", "./..."

    libexec.mkpath
    system "cp", "base.gohtml", libexec
    system "cp", "feed.gohtml", libexec
    system "cp", "channels.gohtml", libexec
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
                <string>-templatedir</string>
                <string>#{libexec}</string>
                <string>-addr</string>
                <string>localhost:8579</string>
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
