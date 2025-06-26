import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSize {
  static const double small = 12.0;
  static const double standard = 14.0;
  static const double standardUp = 16.0;
  static const double medium = 20.0;
  static const double large = 28.0;
}

class ReceiptSize {
  static const double small = 12.0;
  static const double medium = 14.0;
  static const double medium2 = 15.0;
  static const double standard = 16.0;
  static const double midLarge = 18.0;
  static const double large = 24.0;
}

class LabelSize {
  static const double pt6 = 13.6;
  static const double pt8 = 18.1;
  static const double pt10 = 22.6;
  static const double pt12 = 27.2;
  static const double pt47 = 107;
}

class AppTheme {
  static final ThemeData dartTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xFF1B202D),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.alegreyaSans(
        fontSize: FontSize.medium,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.alegreyaSans(
        fontSize: FontSize.large,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.alegreyaSans(
        fontSize: FontSize.small,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.alegreyaSans(
        fontSize: FontSize.standard,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.alegreyaSans(
        fontSize: FontSize.standardUp,
        color: Colors.white,
      ),
    ),
  );
}
