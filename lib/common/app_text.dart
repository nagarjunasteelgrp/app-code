// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  String? title;
  FontWeight? fontWeight;
  double? fontSize;
  double? letterSpacing;
  FontStyle? fontStyle;
  Color? color;
  TextAlign? textAlign;
  int? maxLines;
  double? height;
  dynamic decoration;
  String? fontFamily;
  bool? isPoppins;
  TextOverflow? textOverflow;
  AppText(
      {super.key,
      this.title,
      this.fontWeight,
      this.fontSize,
      this.letterSpacing,
      this.fontStyle,
      this.color,
      this.textAlign,
      this.maxLines,
      this.height,
      this.decoration,
      this.fontFamily,
      this.isPoppins,
      this.textOverflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      textAlign: textAlign ?? TextAlign.start,
      style: isPoppins == false || isPoppins == null
          ? GoogleFonts.outfit(
              height: height,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
              color: color ?? Theme.of(context).colorScheme.secondary,
              fontStyle: fontStyle,
              letterSpacing: letterSpacing,
              decoration: decoration ?? TextDecoration.none)
          : GoogleFonts.poppins(
              height: height,
              fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w500,
              color: color ?? Theme.of(context).colorScheme.secondary,
              fontStyle: fontStyle,
              letterSpacing: letterSpacing,
              decoration: decoration ?? TextDecoration.none),
      maxLines: maxLines,
      overflow: textOverflow ?? TextOverflow.ellipsis,
    );
  }
}
