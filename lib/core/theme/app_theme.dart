import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized text/theme system. Poppins is used app-wide (max 1 font family).
class AppTheme {
  AppTheme._();

  static TextTheme get _textTheme => TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 56,
          fontWeight: FontWeight.w700,
          color: AppColors.darkText,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: AppColors.darkText,
          height: 1.15,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.mutedText,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.mutedText,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.chocolate,
        ),
      );

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.offWhite,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.pastelBlue,
          primary: AppColors.chocolate,
          secondary: AppColors.pastelPeach,
          surface: AppColors.white,
        ),
        textTheme: _textTheme,
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      );
}

/// Simple responsive breakpoints used throughout the app.
class AppBreakpoints {
  AppBreakpoints._();
  static const double mobile = 430;
  static const double tablet = 768;
  static const double desktop = 1366;
  static const double largeDesktop = 1920;

  static bool isMobile(double width) => width < tablet;
  static bool isTablet(double width) => width >= tablet && width < desktop;
  static bool isDesktop(double width) => width >= desktop;
}
