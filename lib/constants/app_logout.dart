import 'dart:io';

import 'package:digital_lync/common/app_button.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:digital_lync/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AppDialog {
  AppDialog._();

  static Future<bool> showDialog(BuildContext context, value,
      {String? title, String? message}) async {
    return await showCupertinoDialog(
      context: context,
      builder: (context) {
        return DefaultTabController(
          length: 2,
          child: CupertinoAlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(2.h),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      labelColor: Theme.of(context).colorScheme.background,
                      unselectedLabelColor: AppColors.BLACK_COLOR,
                      tabs: const [
                        Tab(text: 'Profile'),
                        Tab(text: 'Logout'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  height: 25.h,
                  child: TabBarView(
                    children: [
                      profileUpdate(value),
                      logoutButton(
                          context: context, title: title, message: message),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text("Close"),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget logoutButton(
    {required BuildContext context, String? title, String? message}) {
  return Column(
    children: [
      SizedBox(height: 2.h),
      AppText(
          title: title,
          maxLines: 2,
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.w700),
      SizedBox(height: 2.h),
      AppText(
        title: message,
        fontSize: 20,
        textAlign: TextAlign.center,
        color: Theme.of(context).colorScheme.secondary,
        maxLines: 5,
      ),
      SizedBox(height: 3.h),
      appButton(
        context: context,
        height: 5.h,
        child: Center(
          child: AppText(
              title: 'Yes',
              color: Theme.of(context).colorScheme.background,
              fontWeight: FontWeight.w600),
        ),
        onTap: () {
          Navigator.pop(context, true);
        },
      ),
    ],
  );
}

Widget profileUpdate(value) {
  return Column(
    children: [
      CircleAvatar(
        radius: 65,
        backgroundImage:
            value.profilePicture != 'null' && value.profilePicture != null
                ? value.profilePicture!.startsWith('http')
                    ? NetworkImage(value.profilePicture!)
                    : FileImage(File(value.profilePicture!)) as ImageProvider
                : const AssetImage('assets/images/dummy_person.png'),
      ),
      const SizedBox(height: 16), // Space between image and button
      appButton(
        child: AppText(
          title: 'Upload',
          fontSize: 1.7.h,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        context: Get.context!,
        onTap: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image =
              await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            value.updateProfilePicture(image.path);
            Navigator.of(Get.context!).pop();
          }
        },
        height: 5.h,
      ),
    ],
  );
}
