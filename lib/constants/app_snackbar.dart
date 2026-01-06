import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void showAppSnackBar({
  subtitle,
  String? type,
  required String title,
}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: type == 'success' || type == ''
            ? Get.context!.theme.colorScheme.inversePrimary
            : Get.context!.theme.colorScheme.error,
      ),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: AppText(
          title: title,
          fontSize: 1.8.h,
          color: Get.context!.theme.primaryColor,
        ),
      ),
    ),
  );
  ScaffoldMessenger.of(Get.context!)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
