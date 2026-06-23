class Tapecap < Formula
  desc "Raw DV / HDV tape capture over FireWire for macOS"
  homepage "https://github.com/xingrz/tapecap"
  url "https://github.com/xingrz/tapecap/releases/download/v0.3.1/tapecap-macos-universal.tar.gz"
  version "0.3.1"
  sha256 "00224282d72759da5c041fe3b8377f25ee27923597a2ab304578d103e78bd8cd"
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
