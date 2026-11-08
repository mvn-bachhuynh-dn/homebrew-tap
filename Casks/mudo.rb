# Source of Casks/mudo.rb in https://github.com/mvn-bachhuynh-dn/homebrew-tap.
# The release workflow sets version and sha256 and pushes it there; edit the cask here.
cask "mudo" do
  version "0.13.0"
  sha256 "7db77bbcaca09f97e6a618d0339a475d40e51d30deb074813eabf792f1be5122"

  url "https://github.com/mvn-bachhuynh-dn/mudo/releases/download/v#{version}/MuDo-macos-arm64.zip"
  name "MuDo"
  desc "Floating widget showing which Claude Code and Kiro sessions need you"
  homepage "https://github.com/mvn-bachhuynh-dn/mudo"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "MuDo.app"

  # The app is signed ad hoc, not notarized: clear the quarantine flag so Gatekeeper
  # does not block the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MuDo.app"]
  end

  uninstall quit: "dev.steve.MuDo"

  zap trash: "~/Library/Preferences/dev.steve.MuDo.plist"

  caveats <<~EOS
    If "Monitor this Mac" is on, turn it off in MuDo Settings before uninstalling:
    it removes the mudod LaunchAgent and the agent hooks.
  EOS
end
