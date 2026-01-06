import 'package:digital_lync/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ThemeServices {
  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: AppColors.WHITE_COLOR,
      scaffoldBackgroundColor: AppColors.WHITE_COLOR,
      iconTheme: const IconThemeData(color: AppColors.BLACK_COLOR),
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.WHITE_COLOR),
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        error: AppColors.RED_COLOR,
        onError: AppColors.NAVI_BLUE,
        primary: AppColors.BLUE_COLOR,
        scrim: AppColors.YELLOW_COLOR,
        surface: AppColors.WHITE_COLOR,
        secondary: AppColors.BLACK_COLOR,
        onSecondary: AppColors.GREY_COLOR,
        onSurfaceVariant: AppColors.YELLOW,
        outline: AppColors.PURPLE_SEC_COLOR,
        onPrimaryContainer: AppColors.AMBER,
        inversePrimary: AppColors.GREEN_COLOR,
        onPrimary: AppColors.SECOND_BLUE_COLOR,
        inverseSurface: AppColors.PURPLE_COLOR,
        onSecondaryFixed: AppColors.LIGHT_GREY_COLOR,
        onPrimaryFixed: AppColors.OFF_WHITE_COLOR,
        onSecondaryContainer: AppColors.LIGHT_GREY,
        onInverseSurface: AppColors.LIGHT_GREEN_SEC,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.GREY_COLOR, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.GREY_COLOR, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.GREY_COLOR, width: 0.5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.RED_COLOR, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.GREY_COLOR, width: 0.5),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.BLUE_COLOR,
        unselectedItemColor: AppColors.BLACK_COLOR,
        selectedIconTheme: const IconThemeData(color: AppColors.BLUE_COLOR),
        selectedLabelStyle:
            GoogleFonts.outfit(fontSize: 1.6.h, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            GoogleFonts.outfit(fontSize: 1.6.h, fontWeight: FontWeight.w500),
      ),
    );
  }
}
