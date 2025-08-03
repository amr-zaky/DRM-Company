import UIKit
import Flutter
import GoogleMaps
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDdCKbWxRcIdU1_L4Ckwl_40OgOfNs7AoQ")
    
    // Configure notifications
    configureNotifications()
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func configureNotifications() {
    UNUserNotificationCenter.current().delegate = self
    
    // Create custom notification category with custom sound
    let customSoundAction = UNNotificationAction(
      identifier: "CUSTOM_SOUND_ACTION",
      title: "Custom Sound",
      options: []
    )
    
    let customCategory = UNNotificationCategory(
      identifier: "CUSTOM_SOUND_CATEGORY",
      actions: [customSoundAction],
      intentIdentifiers: [],
      options: []
    )
    
    UNUserNotificationCenter.current().setNotificationCategories([customCategory])
  }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
  // Handle notifications when app is in foreground
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.alert, .badge, .sound])
  }
  
  // Handle notification tap
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    completionHandler()
  }
}
