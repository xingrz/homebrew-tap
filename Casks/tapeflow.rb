cask "tapeflow" do
  arch arm: "arm64", intel: "x64"

  version "1.8.1"
  sha256 arm:   "e146bae88f2213ba54531e12ad47cb8eab7f30786853359f37d6e0099d73c632",
         intel: "736c556826b7a69b0f49f0fe7da42f2a5a55f64d288c1f0ca7ffc55f27f1ac68"

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
