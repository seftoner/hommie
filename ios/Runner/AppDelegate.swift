import UIKit
import Flutter
import workmanager

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    UNUserNotificationCenter.current().delegate = self

        WorkmanagerPlugin.setPluginRegistrantCallback { registry in
            // Registry in this case is the FlutterEngine that is created in Workmanager's
            // performFetchWithCompletionHandler or BGAppRefreshTask.
            // This will make other plugins available during a background operation.
            // DOC: https://github.com/fluttercommunity/flutter_workmanager/blob/d7e6ba5ef3796fafe54d9739e481f01058751b4d/IOS_SETUP.md
            GeneratedPluginRegistrant.register(with: registry)
        }
      
    /// FOR TASKS DEBUG:
    /// Go to file `SwiftWorkmanagerPlugin` -> set brakepoint inside of `schedulePeriodicTask` method
    /// right after `try BGTaskScheduler.shared.submit(request)` line.
    /// Run this command in debugger:
    /// `e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.hommie.workmanager.iOSBackgroundAppRefresh"]`
    
    WorkmanagerPlugin.registerPeriodicTask(withIdentifier: "com.hommie.workmanager.sendSensorData", frequency: NSNumber(value: 60*10))

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
         completionHandler(.alert) // shows banner even if app is in foreground
     }
}
