cask "loki" do
  version "0.1.0"
  sha256 "990fbb71a4ef25d932bb8603e2fedd9ec6615712bb0d4784a8da1b1c31f18da6"

  url "https://github.com/AlmondLabs/loki/releases/download/v#{version}/loki_#{version}_universal.dmg"
  name "loki"
  desc "Desk, inbox, board and recall cards around Letta Code"
  homepage "https://github.com/AlmondLabs/loki"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "loki.app"

  zap trash: [
    "~/.agents/skills/loki",
    "~/.letta/loki",
    "~/.letta/mods/loki.ts",
  ]

  caveats <<~EOS
    loki is not signed with an Apple Developer ID. If macOS says it is damaged, the download was
    quarantined: run `xattr -dr com.apple.quarantine /Applications/loki.app` once, or reinstall with
      brew reinstall --cask --no-quarantine loki
  EOS
end
