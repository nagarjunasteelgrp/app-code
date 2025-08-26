import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String? title;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final FontStyle? fontStyle;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;
  final dynamic decoration;
  final String? fontFamily;
  final TextOverflow? textOverflow;

  const AppText({
    super.key,
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
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.lato(
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
