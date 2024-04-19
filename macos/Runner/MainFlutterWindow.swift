import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame

    /// Primary I am testing app on Mac. All time I need to resize window to size  
    /// close to phone screen. By now set these sizes.
    self.minSize = NSSize(width: 360, height: 640)
    self.maxSize = NSSize(width: 420, height: 840)

    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
