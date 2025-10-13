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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(title: "Do you want to exit?"),
                const SizedBox(height: 20),
                Row(
                  spacing: 15,
                  children: [
                    Expanded(
                      child: appButton(
                        height: 5.h,
                        context: context,
                        onTap: () => exit(0),
                        child: const AppText(
                          title: 'Yes',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: appButton(
                        height: 5.h,
                        context: context,
                        onTap: () => Get.back(),
                        child: const AppText(title: 'No', color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}
