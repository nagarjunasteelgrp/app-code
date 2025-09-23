import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:digital_lync/modules/contacts/provider/current_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<void> showLocationDisclosureDialog(BuildContext context) async {
  bool? userConsent = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Colors.deepPurple),
            SizedBox(width: 8),
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
                children: [
                  Icon(Icons.info_outline, color: Colors.deepPurple),
                  SizedBox(width: 10),
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
            context: context,
            onTap: () async {
              Navigator.pop(context);
              await Provider.of<CurrentLocationProvider>(context, listen: false)
                  .getUserLocation();
            },
            child: const AppText(
              title: "Allow",
              color: Colors.white,
            ),
            radius: 12,
            width: 20.w,
            height: 5.h,
          ),
        ],
      );
    },
  );

  if (userConsent == true) {
    final status = await Permission.locationAlways.request();
    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: AppText(
            color: AppColors.WHITE_COLOR,
            title: "Background location permission granted.",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: AppText(
              title: "Permission not granted.", color: AppColors.WHITE_COLOR),
        ),
      );
    }
  }
}
