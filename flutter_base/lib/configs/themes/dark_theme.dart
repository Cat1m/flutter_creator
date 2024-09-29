import 'package:flutter/material.dart';
import 'package:sample_flutter/configs/color/color.dart';

import 'themes.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      toolbarTextStyle: ThemeData.light().textTheme.displayMedium!.copyWith(
            fontFamily: ThemeConfig.pangramRegular,
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
      iconTheme: const IconThemeData(color: AppColors.white),
    ),
    // textSelectionTheme:
    //     const TextSelectionThemeData(cursorColor: AppColors.white),
    // textTheme: ThemeData.dark().textTheme.copyWith(
    //       titleMedium: GoogleFonts.roboto(color: AppColors.white),
    //       titleSmall: GoogleFonts.roboto(
    //         color: AppColors.white.withOpacity(.5),
    //       ),
    //       displayLarge: GoogleFonts.roboto(
    //         color: AppColors.white,
    //       ),
    //       displayMedium: GoogleFonts.roboto(
    //         color: AppColors.white,
    //         fontWeight: FontWeight.w400,
    //       ),
    //       headlineMedium: GoogleFonts.roboto(color: ThemeConfig.textColorWhite),
    //       displaySmall: GoogleFonts.roboto(
    //         color: AppColors.white,
    //         fontWeight: FontWeight.w400,
    //       ),
    //       bodyMedium: GoogleFonts.roboto(
    //         color: ThemeConfig.textColorWhite,
    //       ),
    //     ),
    // radioTheme: RadioThemeData(
    //   fillColor: WidgetStateColor.resolveWith(
    //       (states) => AppColors.white.withOpacity(.3)),
    // ),
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: AppColors.darkPurplePink,
      primary: AppColors.white,
      onPrimary: AppColors.darkBrownSkin,
      outline: AppColors.black,
      brightness: Brightness.dark,
      surface: AppColors.darkPurpleMain,
      onSurface: AppColors.darkPurpleMain,
      primaryContainer: AppColors.darkPinkStrong,
      onPrimaryContainer: AppColors.darkBrownSkin,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: AppColors.white,
      color: AppColors.darkPurpleMain,
    ),
    primaryColor: AppColors.darkPurpleMain,
    scaffoldBackgroundColor: AppColors.black);
