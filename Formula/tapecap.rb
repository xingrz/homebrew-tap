class Tapecap < Formula
  desc "Raw DV / HDV tape capture over FireWire for macOS"
  homepage "https://github.com/xingrz/tapecap"
  url "https://github.com/xingrz/tapecap/releases/download/v0.4.0/tapecap-macos-universal.tar.gz"
  version "0.4.0"
  sha256 "2b598b10d8c5fd0e7386149e32d6e27633e85cd86bef11e48eea5f92f9815a1f"
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
