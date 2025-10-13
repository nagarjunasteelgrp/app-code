import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<void> showLocationDisclosureDialog() async {
  bool? userConsent = await showDialog<bool>(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          spacing: 8,
          children: [
            Icon(Icons.location_on, color: Colors.deepPurple),
            AppText(
              fontSize: 16,
              title: "Background Location Access",
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText(
              maxLines: 5,
              fontSize: 16,
              title:
                  "This app collects location data in the background to provide real-time tracking and notifications, "
                  "even when the app is closed or not in use.",
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.withValues(alpha: 0.1),
              ),
              padding: const EdgeInsets.all(12),
              child: const Row(
                spacing: 10,
                children: [
                  Icon(Icons.info_outline, color: Colors.deepPurple),
                  Expanded(
                    child: AppText(
                      maxLines: 3,
                      title:
                          "Without this permission, some features may not work properly.",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const AppText(title: "Deny"),
            onPressed: () => Navigator.pop(context, false),
          ),
          appButton(
            radius: 12,
            height: 5.h,
            width: 20.w,
            context: context,
            onTap: () async {
              Navigator.pop(context);
              await Provider.of<CurrentLocationProvider>(context, listen: false)
                  .getUserLocation();
            },
            child: const AppText(title: "Allow", color: Colors.white),
          ),
        ],
      );
    },
  );

  if (userConsent == true) {
    final status = await Permission.locationAlways.request();
    if (status.isGranted) {
      showAppSnackBar(
          // type: 'Error',
          context: Get.context!,
          title: 'Background location permission granted.');
    } else {
      showAppSnackBar(
          type: 'Error',
          context: Get.context!,
          title: "Permission not granted.");
    }
  }
}
