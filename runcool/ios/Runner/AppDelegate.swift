import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Added in Google API Key
    GMSServices.provideAPIKey("AIzaSyBIIdfPyfc9sVM5L9Z4_91c5I_k8XXQIG4")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
