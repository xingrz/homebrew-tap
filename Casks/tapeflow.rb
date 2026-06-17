cask "tapeflow" do
  arch arm: "arm64", intel: "x64"

  version "1.4.1"
  sha256 arm:   "3c913fbcf223a3e976292cfce8dcb09c641fc08e1b43341d05982ba91da1614b",
         intel: "9583f29cfbdeeb2dac65379f5cd7bbaaa2217512869705f3e47ca7391b5faceb"

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
