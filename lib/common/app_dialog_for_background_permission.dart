import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_snackbar.dart';
import 'package:digital_lync/services/app_permissions.dart';
import 'package:digital_lync/services/location_monitor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Future<void> showLocationDisclosureDialog() async {
  await showGeneralDialog<bool>(
    context: Get.context!,
    barrierDismissible: false,
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionDuration: const Duration(milliseconds: 250),
    barrierLabel:
        MaterialLocalizations.of(Get.context!).modalBarrierDismissLabel,
    transitionBuilder: (context, anim, _, __) {
      final scale = Curves.easeInOutCubicEmphasized.transform(anim.value);
      return Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: anim.value,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: AlertDialog(
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
                      Navigator.pop(context, true);
                      await AppPermissions.requestAll();
                      bool granted = await AppPermissions.hasAll();
                      if (granted) {
                        LocationMonitor.startLocationMonitoring();
                        showAppSnackBar(
                          type: 'success',
                          title: 'All permissions granted. Service started.',
                        );
                      } else {
                        showAppSnackBar(
                          type: 'Error',
                          title:
                              "Permissions incomplete. Some features may not work.",
                        );
                      }
                    },
                    child: const AppText(title: "Allow", color: Colors.white),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: const Row(
                  spacing: 8,
                  children: [
                    Icon(Icons.location_on, color: Colors.deepPurple),
                    Expanded(
                      child: AppText(
                        fontSize: 16,
                        title: "Background Location Access",
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppText(
                      maxLines: 5,
                      fontSize: 15,
                      textAlign: TextAlign.start,
                      title:
                          "This app collects location data in the background to provide real-time tracking and notifications, even when the app is closed or not in use.",
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple.withValues(alpha: 0.1),
                      ),
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
              ),
            ),
          ),
        ),
      );
    },
  );
}
