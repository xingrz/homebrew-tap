class Tapecap < Formula
  desc "Raw DV / HDV tape capture over FireWire for macOS"
  homepage "https://github.com/xingrz/tapecap"
  url "https://github.com/xingrz/tapecap/releases/download/v0.3.0/tapecap-macos-universal.tar.gz"
  version "0.3.0"
  sha256 "01cd04198e673d4b5b9e9eeb85824f3c07e0cc8084723dd2a66f02f1cd4cd66a"
  license "MIT"

  # Ships as a prebuilt universal (x86_64 + arm64) binary. macOS 26 Tahoe removed
  # the FireWire stack, so cap the OS at Sequoia.
  depends_on maximum_macos: :sequoia

  def install
    bin.install "tapecap"
  end

  test do
    system bin/"tapecap", "list"
  end
end
