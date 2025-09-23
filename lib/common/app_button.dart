import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget appButton({
  margin,
  padding,
  Color? color,
  Widget? icon,
  Widget? child,
  double? width,
  double? height,
  double? radius,
  verticalMargine,
  Color? borderColor,
  VoidCallback? onTap,
  List<BoxShadow>? boxShadow,
  required BuildContext context,
  border,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        width: width ?? 35.w,
        height: height ?? 5.5.h,
        margin: margin ?? const EdgeInsets.all(0),
        padding: padding ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(radius ?? 5.h),
          color: color ?? Theme.of(context).colorScheme.onError,
        ),
        child: Center(child: child)),
  );
}
