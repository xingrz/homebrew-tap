class Tapecap < Formula
  desc "Raw DV / HDV tape capture over FireWire for macOS"
  homepage "https://github.com/xingrz/tapecap"
  url "https://github.com/xingrz/tapecap/releases/download/v0.1.0/tapecap-macos-universal.tar.gz"
  version "0.1.0"
  sha256 "a74d83705aa988cce90b5d3e45263b6ef1d774b787b6701d940a25acbd53508d"
  license "MIT"

  # Ships as a prebuilt universal (x86_64 + arm64) binary; macOS-only by nature (FireWire).
  depends_on :macos

  def install
    bin.install "tapecap"
  end

  test do
    system bin/"tapecap", "list"
  end
end
