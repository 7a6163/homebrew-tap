cask "fanhuaji" do
  version "2.4.6"
  sha256 "f0805aaa140f19da374699b7db3d93f284d35a12590817014a568cb34ac7e6a6"

  url "https://github.com/7a6163/fanhuaji-tauri/releases/download/v#{version}/Fanhuaji_#{version}_universal.dmg"
  name "Fanhuaji"
  name "繁化姬"
  desc "Chinese text converter desktop app (based on zhconvert.org API)"
  homepage "https://github.com/7a6163/fanhuaji-tauri"

  auto_updates true
  depends_on macos: :catalina

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
