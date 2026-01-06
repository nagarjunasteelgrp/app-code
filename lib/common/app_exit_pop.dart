import 'dart:io';
import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';

Future<bool> showExitPopup(context) async {
  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          spacing: 2.h,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: AppText(title: "Do you want to exit?")),
            Row(
              spacing: 3.w,
              children: [
                Expanded(
                  child: appButton(
                    height: 5.h,
                    context: context,
                    onTap: () => exit(0),
                    child: AppText(title: 'Yes', color: Colors.white),
                  ),
                ),
                Expanded(
                  child: appButton(
                    height: 5.h,
                    context: context,
                    onTap: () => Get.back(),
                    child: AppText(title: 'No', color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      );
    },
  );
}
