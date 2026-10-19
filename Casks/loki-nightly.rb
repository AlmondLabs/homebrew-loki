cask "loki-nightly" do
  version "2026.1019.0-nightly.1ae3f27"
  sha256 "56c9bbcad04fc5e3e962fa0d3a780c5b7e92752fd738a561a4b397cc5fdc5a94"

  url "https://github.com/AlmondLabs/loki/releases/download/nightly/loki_#{version}_universal.dmg"
  name "loki nightly"
  desc "Agents with a canvas, an inbox, a task list and recall cards — built from every merge"
  homepage "https://github.com/AlmondLabs/loki"

  livecheck do
    skip "a rolling prerelease; the cask is rewritten on every merge"
  end

  # One loki at a time: both builds share ~/.loki and the mod's port.
  conflicts_with cask: "AlmondLabs/loki/loki"

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
