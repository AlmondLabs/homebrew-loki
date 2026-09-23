cask "loki" do
  version "2026.9.23"
  sha256 "29f00473a5cc3cea8a0fb693dbea11b80dc4ae25899fcea3c4b91a2c1ca7130e"

  url "https://github.com/AlmondLabs/loki/releases/download/v#{version}/loki_#{version}_universal.dmg"
  name "loki"
  desc "Desk, inbox, board and recall cards around Letta Code"
  homepage "https://github.com/AlmondLabs/loki"

  livecheck do
    url :url
    strategy :github_latest
  end

  # One loki at a time: both builds share ~/.letta/loki, the mod shim and the harness port.
  conflicts_with cask: "AlmondLabs/loki/loki-nightly"

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
