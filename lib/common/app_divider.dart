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
      color: colors ?? Theme.of(context).colorScheme.secondary,
    ),
  );
}
