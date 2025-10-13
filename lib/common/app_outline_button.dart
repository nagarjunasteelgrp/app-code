import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sizer/sizer.dart';

Widget appOutlineButton({
  border,
  double? width,
  double? height,
  double? radius,
  final Color? color,
  VoidCallback? onTap,
  final Widget? child,
  final Color? boxColor,
  List<BoxShadow>? boxShadow,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ?? 35.w,
      height: height ?? 6.h,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: boxColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(radius ?? 2.h),
        border: border ??
            Border.all(color: color ?? context.theme.colorScheme.primary),
      ),
      child: Center(child: child),
    ),
  );
}
