// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Widget appTextfield(
    {required BuildContext context,
    String? hint,
    String? label,
    double? borderRadius,
    bool? isdense,
    hight,
    color,
    image,
    maxLines,
    keyboardType,
    validator,
    title,
    minline,
    controller,
    suffixIcon,
    obscureText,
    prefixIcon,
    readOnly,
    onTap,
    inputFormatters,
    horizontalpadding,
    verticalpading,
    onEditingComplete,
    textInputAction,
    Border? border,
    onChanged,
    backgroundcolor,
    enabledBorder,
    focusedBorder,
    focusedErrorBorder,
    errorBorder}) {
  return TextFormField(
    onEditingComplete: onEditingComplete,
    onChanged: onChanged,
    onTap: onTap,
    validator: validator,
    keyboardType: keyboardType,
    controller: controller,
    inputFormatters: inputFormatters,
    autofocus: false,
    textInputAction: textInputAction ?? TextInputAction.done,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    cursorColor: Theme.of(context).colorScheme.onPrimary,
    readOnly: readOnly ?? false,
    obscureText: obscureText ?? false,
    style: GoogleFonts.outfit(),
    maxLines: maxLines ?? 1,
    decoration: InputDecoration(
      fillColor: Theme.of(context).colorScheme.onSurface,
      filled: true,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: verticalpading ?? 1.6.h,horizontal: 2.5.w),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 1.5.w),
        borderSide:
            Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 1.5.w),
        borderSide:
            Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide,
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 1.5.w),
          borderSide: Theme.of(context)
              .inputDecorationTheme
              .focusedErrorBorder!
              .borderSide
          ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 3.w),
          borderSide:
              Theme.of(context).inputDecorationTheme.errorBorder!.borderSide),
      suffixIcon: suffixIcon,
      icon: prefixIcon,
      hintText: hint,
      errorMaxLines: 2,
      errorStyle: GoogleFonts.outfit(),
      hintStyle: GoogleFonts.outfit(),
      border: InputBorder.none,
    ),
  );
}
