import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget appCircleIcon(
    {Widget? child,
    required BuildContext context,
    VoidCallback? onTap,
    Color? colors,
    double? margin,
    double? width,
    double? height,
    verticalmargin,
    double? radius,
    Widget? icon,
    List<BoxShadow>? boxShadow,
    border}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        height: height ?? 10.w,
        width: width ?? 10.w,
        decoration: BoxDecoration(
            color: colors,
            border: border,
            borderRadius: BorderRadius.circular(radius ?? 10.w),
            boxShadow: boxShadow),
        child: Center(child: child)),
  );
}
