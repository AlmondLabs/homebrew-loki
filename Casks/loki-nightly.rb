cask "loki-nightly" do
  version "2026.1116.0-nightly.302"
  sha256 "163b2c511de406b843477aeb0e6e50f5af184a6625f959f6d903d356675a5783"

  url "https://github.com/AlmondLabs/loki/releases/download/nightly/loki_#{version}_universal.dmg"
  name "loki nightly"
  desc "Agents with a canvas, an inbox, a task list and recall cards — built from every merge"
  homepage "https://github.com/AlmondLabs/loki"

  livecheck do
    skip "a rolling prerelease; the cask is rewritten on every merge"
  end

  # Homebrew finishes the sentence: "has been deprecated because it …".
  deprecate! date: "2026-11-16", because: "is replaced by the loki cask and the Nightly channel in loki's About"

  # loki replaces itself through its signed updater; brew upgrade leaves it to that.
  auto_updates true

  # One loki at a time: both builds share ~/.loki and the mod's port.
  conflicts_with cask: "AlmondLabs/loki/loki"

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
