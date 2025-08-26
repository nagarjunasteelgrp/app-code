import UIKit
import Flutter
import flutter_background_service_ios
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"
    GMSServices.provideAPIKey("AIzaSyB6P55VaSsCmcFlxWNVwetPXqEFZzwTeKI")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
