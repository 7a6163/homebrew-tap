cask "fanhuaji" do
  version "2.4.1"
  sha256 "6f441bd7be39f0bf1eb70c8a5b652747f0893f5b0635d1733511ceb824a8cd32"

  url "https://github.com/7a6163/fanhuaji-tauri/releases/download/v#{version}/Fanhuaji_#{version}_universal.dmg",
      verified: "github.com/7a6163/fanhuaji-tauri/"
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
