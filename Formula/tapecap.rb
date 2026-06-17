class Tapecap < Formula
  desc "Raw DV / HDV tape capture over FireWire for macOS"
  homepage "https://github.com/xingrz/tapecap"
  url "https://github.com/xingrz/tapecap/releases/download/v0.2.0/tapecap-macos-universal.tar.gz"
  version "0.2.0"
  sha256 "9d29df90e6c0eae8195f48b4c96a92528bbd647ce609a00a3ed3a750ee759b2a"
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
