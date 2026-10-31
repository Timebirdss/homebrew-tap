cask "app-updates" do
  version "1.0.2"
  sha256 "8c726d8e60e3473cdd655b3365c996bc13cc3ae94bdac45a18abc0b3200ca3d9"

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
