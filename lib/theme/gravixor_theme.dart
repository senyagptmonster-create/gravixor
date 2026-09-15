import 'package:flutter/material.dart';

class GravixorTheme {
  static const background = Color(0xFF080C14);
  static const surface = Color(0xFF111827);
  static const card = Color(0xFF1F2937);
  static const cyan = Color(0xFF00E5FF);
  static const emerald = Color(0xFF10B981);
  static const amber = Color(0xFFF59E0B);
  static const textPrimary = Color(0xFFF9FAFB);
  static const textSecondary = Color(0xFF9CA3AF);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: cyan,
      cardColor: card,
      fontFamily: 'AppFont',
      colorScheme: const ColorScheme.dark(
        primary: cyan,
        secondary: emerald,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
