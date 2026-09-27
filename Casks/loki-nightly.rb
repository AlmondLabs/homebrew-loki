cask "loki-nightly" do
  version "2026.9.27-nightly.bf8b5d7"
  sha256 "824f90093be26857f7681783906bce0eaa56f7a4bf42f8169fdb93096b67660a"

  url "https://github.com/AlmondLabs/loki/releases/download/nightly/loki_#{version}_universal.dmg"
  name "loki nightly"
  desc "Desk, inbox, board and recall cards around Letta Code — built from every merge"
  homepage "https://github.com/AlmondLabs/loki"

  livecheck do
    skip "a rolling prerelease; the cask is rewritten on every merge"
  end

  # One loki at a time: both builds share ~/.letta/loki, the mod shim and the harness port.
  conflicts_with cask: "AlmondLabs/loki/loki"

  depends_on macos: :ventura
  # Letta Code is installed with npm on first launch (docs/manual.md › Requirements); Node brings npm.
  depends_on formula: "node"

  app "loki.app"

  zap trash: [
    "~/.agents/skills/loki",
    "~/.letta/loki",
    "~/.letta/mods/loki.ts",
  ]

  caveats <<~EOS
    loki is not signed with an Apple Developer ID, so macOS will call the download "damaged" the
    first time. Clear the quarantine flag once and it opens:
      xattr -dr com.apple.quarantine /Applications/loki.app
    (or open it, dismiss the dialog, and allow it under System Settings › Privacy & Security).
  EOS
end
