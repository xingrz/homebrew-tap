cask "tapeflow" do
  arch arm: "arm64", intel: "x64"

  version "1.5.0"
  sha256 arm:   "be8e6f7ee969865dc6943fccb033e4ffa8d160c742777d16aa90749959cf31e7",
         intel: "8979fad1da74a3608ffba0f4904dddf73d5e0d6ea989821eaec5409b3a0885e5"

  url "https://github.com/xingrz/tapeflow/releases/download/v#{version}/TapeFlow-#{version}-#{arch}.dmg",
      verified: "github.com/xingrz/tapeflow/"
  name "TapeFlow"
  desc "Merge overlapping captures of worn DV/HDV tapes into one video"
  homepage "https://github.com/xingrz/tapeflow"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :catalina

  app "TapeFlow.app"

  zap trash: [
    "~/Library/Application Support/TapeFlow",
    "~/Library/Preferences/me.xingrz.tapeflow.plist",
    "~/Library/Saved Application State/me.xingrz.tapeflow.savedState",
  ]

  caveats <<~EOS
    TapeFlow is not notarized, so macOS Gatekeeper blocks it on first launch.
    After installing, clear the quarantine flag:

      sudo xattr -dr com.apple.quarantine "#{appdir}/TapeFlow.app"
  EOS
end
