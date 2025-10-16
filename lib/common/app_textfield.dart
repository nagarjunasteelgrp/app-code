import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Widget appTextField({
  onTap,
  readOnly,
  maxLines,
  maxLength,
  onChanged,
  validator,
  controller, 
  suffixIcon,
  prefixIcon,
  obscureText,
  String? hint,
  verticalPadding,
  inputFormatters,
  textInputAction,
  onEditingComplete,
  double? borderRadius,
  TextInputType? textInputType,
  required BuildContext context,
}) {
  return TextFormField(
    onTap: onTap,
    autofocus: false,
    validator: validator,
    onChanged: onChanged,
    maxLength: maxLength,
    controller: controller,
    maxLines: maxLines ?? 1,
    keyboardType: textInputType,
    style: GoogleFonts.outfit(),
    readOnly: readOnly ?? false,
    inputFormatters: inputFormatters,
    obscureText: obscureText ?? false,
    onEditingComplete: onEditingComplete,
    cursorColor: context.theme.colorScheme.onPrimary,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    textInputAction: textInputAction ?? TextInputAction.done,
    decoration: InputDecoration(
      filled: true,
      isDense: true,
      hintText: hint,
      icon: prefixIcon,
      errorMaxLines: 2,
      suffixIcon: suffixIcon,
      border: InputBorder.none,
      hintStyle: GoogleFonts.outfit(),
      errorStyle: GoogleFonts.outfit(),
      fillColor: context.theme.colorScheme.onSurface,
      contentPadding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 1.6.h, horizontal: 2.5.w),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 1.5.w),
        borderSide:
            context.theme.inputDecorationTheme.enabledBorder!.borderSide,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 1.5.w),
        borderSide:
            context.theme.inputDecorationTheme.focusedBorder!.borderSide,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 1.5.w),
        borderSide:
            context.theme.inputDecorationTheme.focusedErrorBorder!.borderSide,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 3.w),
        borderSide: context.theme.inputDecorationTheme.errorBorder!.borderSide,
      ),
    ),
  );
}
