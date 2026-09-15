import 'package:flutter/material.dart';

class GravixorPalette {
  static const bg = Color(0xFF0F0F12);
  static const surface = Color(0xFF18181F);
  static const edge = Color(0xFF252533);
  static const accent = Color(0xFFE11D48);
  static const accent2 = Color(0xFFFB7185);
  static const ink = Color(0xFFFFF1F2);
  static const inkMuted = Color(0xFF9E9EA8);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      scaffoldBackgroundColor: bg,
      colorScheme: const ColorScheme.dark(
        surface: surface,
        primary: accent,
        secondary: accent2,
        onSurface: ink,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: ink,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: edge,
      ),
    );
  }
}
