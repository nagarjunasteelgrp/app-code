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
                  spacing: 20,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                      fontSize: 16,
                      title:
                          "Are you sure you want to delete all notifications?",
                    ),
                    Row(
                      spacing: 15,
                      children: [
                        Expanded(
                          child: appButton(
                            height: 5.h,
                            context: context,
                            onTap: () => Get.back(),
                            child:
                                const AppText(title: 'No', color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: appButton(
                            height: 5.h,
                            context: context,
                            onTap: () async {
                              await provider.deleteAllNotification(context);
                              Get.back();
                            },
                            child: const AppText(
                                title: 'Yes', color: Colors.white),
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
