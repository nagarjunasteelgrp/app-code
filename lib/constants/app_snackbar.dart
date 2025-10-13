import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sizer/sizer.dart';

void showAppSnackBar({
  subtitle,
  String? type,
  required String title,
  required BuildContext context,
}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: type == 'success' || type == ''
            ? context.theme.colorScheme.inversePrimary
            : context.theme.colorScheme.error,
      ),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: AppText(
          title: title,
          fontSize: 1.8.h,
          color: context.theme.primaryColor,
        ),
      ),
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
