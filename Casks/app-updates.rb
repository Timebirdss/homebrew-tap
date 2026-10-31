cask "app-updates" do
  version "1.0.1"
  sha256 "d49ed845682329f341dad9c1929dffac60c1f25a047cf6f7bc876f4714681bfc"

  url "https://github.com/Timebirdss/swiftbar-app-updates/archive/refs/tags/v#{version}.tar.gz"
  name "App Updates"
  desc "Homebrew and Mac App Store updates in the SwiftBar menu bar"
  homepage "https://github.com/Timebirdss/swiftbar-app-updates"

  depends_on formula: "jq"
  depends_on macos: ">= :big_sur"

  binary "#{staged_path}/swiftbar-app-updates-#{version}/bin/app-updates"

  postflight do
    plugin_dir = File.expand_path("~/Library/Application Support/SwiftBar/Plugins")
    FileUtils.mkdir_p(plugin_dir)
    src = "#{staged_path}/swiftbar-app-updates-#{version}/plugin/app-updates.5m.sh"
    dst = "#{plugin_dir}/app-updates.5m.sh"
    FileUtils.cp(src, dst)
    FileUtils.chmod(0o755, dst)
    system_command "/usr/bin/open", args: ["-g", "swiftbar://refreshplugin?name=app-updates"]
  end

  uninstall delete: "#{Dir.home}/Library/Application Support/SwiftBar/Plugins/app-updates.5m.sh"

  caveats <<~EOS
    The plugin was copied into your SwiftBar plugin folder and the menu bar icon
    should appear within a few seconds. If it does not, open SwiftBar and check
    that "App Updates" is enabled.

    Configuration lives in ~/.config/app-updates/config
    (proxy, ignored packages, skipped versions, check interval).
  EOS
end
