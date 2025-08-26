import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget appOutlineButton({
  final Widget? child,
  required BuildContext context,
  VoidCallback? onTap,
  final Color? color,
  final Color? boxColor,
  double? margin,
  double? width,
  double? height,
  verticalmargin,
  double? radius,
  Widget? icon,
  List<BoxShadow>? boxShadow,
  border,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        height: height ?? 6.h,
        width: width ?? 35.w,
        decoration: BoxDecoration(
            color: boxColor ?? Colors.transparent,
            border: border ??
                Border.all(
                    color: color ?? Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(radius ?? 2.h),
            boxShadow: boxShadow),
        child: Center(child: child)),
  );
}
