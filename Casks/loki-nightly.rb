cask "loki-nightly" do
  version "2026.9.22-nightly.a59840d"
  sha256 "b739a837501005ec4cf2b3b481ffbe9e51b9fda0c53fd29f3526a83158e24f6c"

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
