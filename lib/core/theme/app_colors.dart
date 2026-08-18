import 'package:flutter/material.dart';

/// Centralized color system for Craving for Momo.
/// Do not hardcode colors elsewhere — reference AppColors instead.
class AppColors {
  AppColors._();

  // Core brand gradient (exact colors — do not change)
  static const Color pastelBlue = Color(0xFFC9D3EC);
  static const Color pastelPeach = Color(0xFFFED7B8);

  // Neutrals
  static const Color darkText = Color(0xFF252525);
  static const Color mutedText = Color(0xFF6B6B70);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFAF9F7);
  static const Color cream = Color(0xFFFFF7EF);

  // Accent / neutral supporting colors
  static const Color chocolate = Color(0xFF4A3428);
  static const Color borderGlass = Color(0x33FFFFFF); // translucent white border
  static const Color shadowSoft = Color(0x1A252525);
  static const Color success = Color(0xFF3E9A5B);
  static const Color danger = Color(0xFFD9534F);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pastelBlue, pastelPeach],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [pastelPeach, pastelBlue],
  );

  static LinearGradient glassGradient({double opacity = 0.55}) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        white.withOpacity(opacity),
        white.withOpacity(opacity - 0.15 < 0 ? 0.1 : opacity - 0.15),
      ],
    );
  }
}
