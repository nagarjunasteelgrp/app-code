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
              spacing: 2.h,
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                      borderRadius: BorderRadius.circular(2.h),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.h),
                        color: context.theme.colorScheme.primary,
                      ),
                      unselectedLabelColor: AppColors.BLACK_COLOR,
                      labelColor: context.theme.colorScheme.background,
                      tabs: const [Tab(text: 'Profile'), Tab(text: 'Logout')],
                    ),
                  ),
                ),
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
                child: const AppText(title: "Close"),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget logoutButton({
  String? title,
  String? message,
  required BuildContext context,
}) {
  return Column(
    spacing: 2.h,
    children: [
      AppText(
        maxLines: 2,
        fontSize: 20,
        title: title,
        fontWeight: FontWeight.w700,
        color: context.theme.colorScheme.primary,
      ),
      AppText(
        maxLines: 5,
        fontSize: 20,
        title: message,
        textAlign: TextAlign.center,
        color: context.theme.colorScheme.secondary,
      ),
      const SizedBox(),
      appButton(
        height: 5.h,
        context: context,
        onTap: () => Navigator.pop(context, true),
        child: Center(
          child: AppText(
            title: 'Yes',
            fontWeight: FontWeight.w600,
            color: context.theme.colorScheme.background,
          ),
        ),
      ),
    ],
  );
}

Widget profileUpdate(value) {
  return SingleChildScrollView(
    child: Column(
      children: [
        CircleAvatar(
          radius: 65,
          backgroundImage:
              value.profilePicture != 'null' && value.profilePicture != null
                  ? (value.profilePicture!.startsWith('http')
                      ? NetworkImage(value.profilePicture!)
                      : FileImage(File(value.profilePicture!))) as ImageProvider
                  : const AssetImage('assets/images/dummy_person.png'),
          onBackgroundImageError: (_, __) {},
        ),
        const SizedBox(height: 16),
        appButton(
          height: 5.h,
          context: Get.context!,
          child: AppText(
            title: 'Upload',
            fontSize: 1.7.h,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              value.updateProfilePicture(image.path);
              Get.back();
            }
          },
        ),
      ],
    ),
  );
}
