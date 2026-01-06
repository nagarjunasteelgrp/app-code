import 'package:animated_digit/animated_digit.dart';
import 'package:digital_lync/common/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class RowTextWidget extends StatelessWidget {
  final bool? brands;
  final String? brandsTitle;
  final dynamic value1;
  final String label1;
  final String value2;
  final String label2;
  final String value3;
  final String label3;
  const RowTextWidget({
    super.key,
    required this.value1,
    required this.label1,
    required this.value2,
    required this.label2,
    required this.value3,
    required this.label3,
    this.brands = false,
    this.brandsTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          brands == true ? AppText(title: brandsTitle) : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  spacing: 0.5.h,
                  children: [
                    AnimatedDigitWidget(
                      fractionDigits: 2,
                      value:
                          double.tryParse(value1.toString())?.toDouble() ?? 0,
                      textStyle: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: context.theme.colorScheme.secondary,
                      ),
                    ),
                    AppText(
                      title: label1,
                      color: context.theme.colorScheme.onSecondary,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Dash(
                    length: 60,
                    dashLength: 3,
                    direction: Axis.vertical,
                    dashColor: context.theme.colorScheme.secondary,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
              Expanded(
                  child: Column(
                spacing: 0.5.h,
                children: [
                  AnimatedDigitWidget(
                    fractionDigits: 2,
                    value: double.tryParse(value2.toString())?.toDouble() ?? 0,
                    textStyle: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: context.theme.colorScheme.secondary,
                    ),
                  ),
                  AppText(
                    title: label2,
                    color: context.theme.colorScheme.onSecondary,
                  ),
                ],
              )),
              Column(
                children: [
                  Dash(
                    length: 60,
                    dashLength: 3,
                    direction: Axis.vertical,
                    dashColor: context.theme.colorScheme.secondary,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
              Expanded(
                child: Column(
                  spacing: 0.5.h,
                  children: [
                    AnimatedDigitWidget(
                      fractionDigits: 2,
                      textStyle: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: context.theme.colorScheme.secondary,
                      ),
                      value:
                          double.tryParse(value3.toString())?.toDouble() ?? 0,
                    ),
                    AppText(
                      title: label3,
                      color: context.theme.colorScheme.onSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
