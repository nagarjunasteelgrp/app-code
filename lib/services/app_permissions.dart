import 'package:digital_lync/common/app_dialog_for_background_permission.dart';
import 'package:digital_lync/services/location_monitor.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static Future<void> checkAndShowDialog() async {
    bool isGranted = await AppPermissions.hasAll();

    if (!isGranted) {
      if (Get.context != null) {
        await showLocationDisclosureDialog();
      }
    } else {
      LocationMonitor.startLocationMonitoring();
    }
  }

  static Future<void> requestAll() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    if (await Permission.locationWhenInUse.isDenied) {
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.locationAlways.isDenied) {
      await Permission.locationAlways.request();
    }
    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      await Permission.ignoreBatteryOptimizations.request();
    }
  }

  static Future<bool> hasAll() async {
    bool notification = await Permission.notification.isGranted;
    bool locationAlways = await Permission.locationAlways.isGranted;
    return notification && locationAlways;
  }
}
