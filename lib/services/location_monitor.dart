import 'dart:async';
import 'package:digital_lync/constants/app_dialog_box.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationMonitor {
  static bool isDialogOpen = false;
  static bool isSettingsDialogOpen = false;
  static Timer? _locationTimer;

  static void startLocationMonitoring() {
    _locationTimer?.cancel();

    _locationTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();

      if ((!serviceEnabled || permission == LocationPermission.deniedForever) && !isDialogOpen) {
        isDialogOpen = true;
        showLocationDialog(permission);
      }
    });
  }

  static void showLocationDialog(LocationPermission permission) async {
    if (permission == LocationPermission.deniedForever) {
      if (!isSettingsDialogOpen) {
        isSettingsDialogOpen = true;
        AppDialogBox.showConfirmationDialog(
          context: Get.context!,
          onYes: () async {
            await Geolocator.openAppSettings();
          },
          headerTitle: "Location access is permanently denied. Please enable it in settings.",
          customButtonText: "Open Settings",
          title: "Permission Required",
        ).then((_) {
          isSettingsDialogOpen = false;
          isDialogOpen = false;
        });
      }
    } else {
      AppDialogBox.showConfirmationDialog(
        context: Get.context!,
        onYes: () async {
          await enableLocationService();
        },
        headerTitle: "Please enable location services to continue using the app.",
        customButtonText: "Enable",
        title: "Location Required",
      ).then((_) {
        isDialogOpen = false;
      });
    }
  }

  static Future<void> enableLocationService() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    // Request permission
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
    }

    if (serviceEnabled &&
        (permission == PermissionStatus.granted ||
            permission == PermissionStatus.grantedLimited)) {
      isDialogOpen = false;
      Get.back();
    }
  }
}
