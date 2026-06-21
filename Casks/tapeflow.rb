cask "tapeflow" do
  arch arm: "arm64", intel: "x64"

  version "1.7.0"
  sha256 arm:   "5bc3a7d270ba21a00ed565a8f955ad8a36e61122198db2b260cdfec499763564",
         intel: "53218654663ec69e34f3f291903dc9f3f8da125b55302a10bd43e0e13d52a570"

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
