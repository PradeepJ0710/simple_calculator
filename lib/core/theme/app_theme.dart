import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryLight = Color(0xFF1E88E5);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Button Colors
  static const Color numberButtonLight = Color(0xFFFFFFFF);
  static const Color numberButtonDark = Color(0xFF2C2C2C);
  static const Color operatorButtonLight = Color(0xFFE3F2FD);
  static const Color operatorButtonDark = Color(0xFF1565C0);
  static const Color equalsButtonLight = Color(0xFF1E88E5);
  static const Color equalsButtonDark = Color(0xFF42A5F5);
  static const Color functionButtonLight = Color(0xFFFFEBEE);
  static const Color functionButtonDark = Color(0xFFB71C1C);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryLight,
    scaffoldBackgroundColor: backgroundLight,
    textTheme: GoogleFonts.robotoTextTheme().apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black87,
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryLight,
      secondary: primaryLight,
      surface: surfaceLight,
      // background: backgroundLight,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryDark,
    scaffoldBackgroundColor: backgroundDark,
    textTheme: GoogleFonts.robotoTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    colorScheme: const ColorScheme.dark(
      primary: primaryDark,
      secondary: primaryDark,
      surface: surfaceDark,
      // background: backgroundDark,
    ),
  );
}
