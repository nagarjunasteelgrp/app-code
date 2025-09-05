import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  /// Request all runtime permissions (Android 13–15)
  static Future<void> requestAll() async {
    // 🔔 Notification (Android 13+)
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // 📍 Foreground location
    if (await Permission.locationWhenInUse.isDenied) {
      await Permission.locationWhenInUse.request();
    }

    // 🌍 Background location (Android 10+)
    if (await Permission.locationAlways.isDenied) {
      await Permission.locationAlways.request();
    }

    // 🔋 Battery optimization ignore
    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      await Permission.ignoreBatteryOptimizations.request();
    }
  }

  /// Check if required permissions are granted
  static Future<bool> hasAll() async {
    return await Permission.notification.isGranted &&
        await Permission.locationWhenInUse.isGranted &&
        await Permission.locationAlways.isGranted;
  }
}
