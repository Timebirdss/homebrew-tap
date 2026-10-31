cask "app-updates" do
  version "1.1.0"
  sha256 "977284a1a52fc6152c818c00fb538fc3364edbab1e8f631049b7d9524dad36ad"

  url "https://github.com/Timebirdss/swiftbar-app-updates/archive/refs/tags/v#{version}.tar.gz"
  name "App Updates"
  desc "Homebrew and Mac App Store updates in the SwiftBar menu bar"
  homepage "https://github.com/Timebirdss/swiftbar-app-updates"

  depends_on formula: "jq"
  depends_on macos: :big_sur

  binary "#{staged_path}/swiftbar-app-updates-#{version}/bin/app-updates"

  # Artifacts create the parent directory and are removed on uninstall as the
  # current user, so no postflight block and no sudo password prompt.
  artifact "#{staged_path}/swiftbar-app-updates-#{version}/plugin/app-updates.5m.sh",
           target: "#{Dir.home}/Library/Application Support/SwiftBar/Plugins/app-updates.5m.sh"

  caveats <<~EOS
    The plugin was copied into your SwiftBar plugin folder; the menu bar icon
    should appear within a few seconds. If it does not, open SwiftBar and check
    that "App Updates" is enabled.

    Configuration lives in ~/.config/app-updates/config
    (proxy, ignored packages, skipped versions, check interval).
  EOS
end
