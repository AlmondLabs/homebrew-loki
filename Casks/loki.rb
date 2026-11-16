cask "loki" do
  version "2026.1116.0"
  sha256 "fdbbc1cf9d5041ffc5c38bc2fffcb387b74c6f09757a35cdb94ea725c6299192"

  url "https://github.com/AlmondLabs/loki/releases/download/v#{version}/loki_#{version}_aarch64.dmg"
  name "loki"
  desc "Agents with a canvas, an inbox, a task list and recall cards"
  homepage "https://github.com/AlmondLabs/loki"

  livecheck do
    url :url
    strategy :github_latest
  end

  # loki replaces itself through its signed updater; brew upgrade leaves it to that.
  auto_updates true

  # One loki at a time: both builds share ~/.loki and the mod's port.
  conflicts_with cask: "AlmondLabs/loki/loki-nightly"

  # Apple silicon only: Homebrew refuses an Intel Mac with its own message.
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "loki.app"

  zap trash: [
    "~/.agents/skills/loki",
    "~/.loki",
  ]

  caveats <<~EOS
    loki is not signed with an Apple Developer ID, so macOS will call the download "damaged" the
    first time. Clear the quarantine flag once and it opens:
      xattr -dr com.apple.quarantine /Applications/loki.app
    (or open it, dismiss the dialog, and allow it under System Settings › Privacy & Security).
  EOS
end
