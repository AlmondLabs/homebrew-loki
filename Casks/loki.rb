cask "loki" do
  version "2026.1011.5"
  sha256 "6ac7e7eece47dd746f32d750c52e74b4e61a7c499bdb5d67d02b2e27524382a1"

  url "https://github.com/AlmondLabs/loki/releases/download/v#{version}/loki_#{version}_universal.dmg"
  name "loki"
  desc "Agents with a canvas, an inbox, a board and recall cards"
  homepage "https://github.com/AlmondLabs/loki"

  livecheck do
    url :url
    strategy :github_latest
  end

  # One loki at a time: both builds share ~/.loki and the mod's port.
  conflicts_with cask: "AlmondLabs/loki/loki-nightly"

  depends_on macos: :ventura
  # loki's daemon runs on Node 22.19 or newer (docs/manual.md › Requirements).
  depends_on formula: "node"

  app "loki.app"

  zap trash: [
    "~/.agents/skills/loki",
    "~/.loki",
    "~/.letta/loki",
  ]

  caveats <<~EOS
    loki is not signed with an Apple Developer ID, so macOS will call the download "damaged" the
    first time. Clear the quarantine flag once and it opens:
      xattr -dr com.apple.quarantine /Applications/loki.app
    (or open it, dismiss the dialog, and allow it under System Settings › Privacy & Security).
  EOS
end
