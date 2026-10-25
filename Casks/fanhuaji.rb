cask "fanhuaji" do
  version "2.5.3"
  sha256 "95d9903cbae58118c8abb0456c9cc947973075ee25cd259f2be53200f26ee0da"

  url "https://github.com/fanhuaji-desktop/fanhuaji-tauri/releases/download/v#{version}/Fanhuaji_#{version}_universal.dmg"
  name "Fanhuaji"
  name "繁化姬"
  desc "Chinese text converter desktop app (based on zhconvert.org API)"
  homepage "https://github.com/fanhuaji-desktop/fanhuaji-tauri"

  auto_updates true

  app "Fanhuaji.app"

  zap trash: [
    "~/Library/Application Support/org.zhconvert.fanhuaji",
    "~/Library/Caches/org.zhconvert.fanhuaji",
    "~/Library/Preferences/org.zhconvert.fanhuaji.plist",
    "~/Library/Saved Application State/org.zhconvert.fanhuaji.savedState",
    "~/Library/WebKit/org.zhconvert.fanhuaji",
  ]

  caveats <<~EOS
    #{token} is not signed by Apple. The first time you open it, macOS may say
    it cannot be opened. Go to System Settings > Privacy & Security and click
    "Open Anyway", or run:
      xattr -cr "/Applications/Fanhuaji.app"
  EOS
end
