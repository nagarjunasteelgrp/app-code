import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget appDivider(
    {
      required BuildContext context,
      vertical,
      Color? colors
    }) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: vertical ?? 1.5.h),
    child: Divider(
      thickness: 0.5,
      color: colors ?? Theme.of(context).colorScheme.secondary.withOpacity(0.3),
    ),
  );
}
