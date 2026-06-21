cask "tapeflow" do
  arch arm: "arm64", intel: "x64"

  version "1.6.2"
  sha256 arm:   "afad05b7089f202dbc941f3d8ca263d0df0b73d1ee77d1ac4d685932ac5507db",
         intel: "a84829329cc6028dbd26b08be9b44e9feda0f858ccd1937b33a09a4e540c1997"

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
