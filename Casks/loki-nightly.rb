cask "loki-nightly" do
  version "2026.1116.1-nightly.307"
  sha256 "9c765fb5a09f8618a73509dd66fbd85c6c85f86999ed1ba1b87b41790c990c2c"

  url "https://github.com/AlmondLabs/loki/releases/download/nightly/loki_#{version}_aarch64.dmg"
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
