import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final Color? color;
  final String? title;
  final int? maxLines;
  final double? height;
  final double? fontSize;
  final String? fontFamily;
  final dynamic decoration;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;

  const AppText({
    super.key,
    this.title,
    this.color,
    this.height,
    this.fontSize,
    this.maxLines,
    this.textAlign,
    this.fontStyle,
    this.fontWeight,
    this.decoration,
    this.fontFamily,
    this.textOverflow,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      overflow: textOverflow ?? TextOverflow.ellipsis,
      style: GoogleFonts.lato(
        height: height,
        fontSize: fontSize,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w500,
        decoration: decoration ?? TextDecoration.none,
        color: color ?? context.theme.colorScheme.secondary,
      ),
    );
  }
}
