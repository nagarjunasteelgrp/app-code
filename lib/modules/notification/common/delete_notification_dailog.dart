import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/modules/notification/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

customDialogBoxNotification(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: ChangeNotifierProvider.value(
          value: NotificationProvider(),
          child: Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Are you sure you want to delete all notifications?",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: appButton(
                            context: context,
                            onTap: () {
                              Get.back();
                            },
                            child: AppText(
                              title: 'No',
                              color: Colors.white,
                            ),
                            height: 5.h,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: appButton(
                            context: context,
                            onTap: () async {
                              await provider.deleteAllNotification(context);
                              Get.back();
                            },
                            child: AppText(
                              title: 'Yes',
                              color: Colors.white,
                            ),
                            height: 5.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
