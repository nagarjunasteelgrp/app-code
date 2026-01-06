import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget appCircleIcon({
  Widget? icon,
  Widget? child,
  Color? colors,
  double? width,
  Border? border,
  double? height,
  double? radius,
  VoidCallback? onTap,
  List<BoxShadow>? boxShadow,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height ?? 10.w,
      width: width ?? 10.w,
      decoration: BoxDecoration(
        color: colors,
        border: border,
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(radius ?? 10.w),
      ),
      child: Center(child: child),
    ),
  );
}
