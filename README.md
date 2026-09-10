# homebrew-loki

The Homebrew tap for [loki](https://github.com/skilp4d/loki), a macOS app around Letta Code.

```bash
brew install --cask --no-quarantine skilp4d/loki/loki
```

`--no-quarantine` matters: the app is not signed with an Apple Developer ID, and without the flag macOS refuses
to open it as "damaged". Upgrade with `brew upgrade --cask loki`.

`Casks/loki.rb` is written by loki's release workflow each time a release is published; do not edit it by hand.
