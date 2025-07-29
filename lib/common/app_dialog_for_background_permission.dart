import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../modules/contacts/provider/current_location_provider.dart';

Future<void> showLocationDisclosureDialog(BuildContext context) async {
  bool? userConsent = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.deepPurple),
            const SizedBox(width: 8),
            AppText(title: "Background Location Access",fontSize: 16,),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             AppText(title:
              "This app collects location data in the background to provide real-time tracking and notifications, "
                  "even when the app is closed or not in use.",
              fontSize: 16,
               maxLines: 5,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.deepPurple),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppText(title:
                      "Without this permission, some features may not work properly.",
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: AppText(title: "Deny"),
          ),
          // appButton(context: context,onTap: () => Navigator.pop(context, true),child: AppText(title: "Allow",color: Colors.white,),
          appButton(context: context,onTap: ()  async {
            Navigator.pop(context);
            await Provider.of<CurrentLocationProvider>(context, listen: false).getUserLocation();
          },child: AppText(title: "Allow",color: Colors.white,),
          radius: 12,width: 20.w,height: 5.h,
          ),
        ],
      );
    },
  );

  if (userConsent == true) {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await Provider.of<CurrentLocationProvider>(context, listen: false)
    //       .getUserLocation();
    // });
    final status = await Permission.locationAlways.request();
    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: AppText(title: "Background location permission granted.",color: AppColors.WHITE_COLOR),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: AppText(title: "Permission not granted.",color: AppColors.WHITE_COLOR),
        backgroundColor: Colors.red,
      ));
    }
  }
}
