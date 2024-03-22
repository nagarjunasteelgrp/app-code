import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget appButton(
    {Widget? child,
    required BuildContext context,
    VoidCallback? onTap,
    Color? color,
    Color? borderColor,
    margin,
    padding,
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
        height: height ?? 5.5.h,
        width: width ?? 35.w,
        margin: margin ?? const EdgeInsets.all(0),
        padding: padding ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(radius ?? 5.h),
            boxShadow: boxShadow),
        child: Center(child: child)),
  );
}
