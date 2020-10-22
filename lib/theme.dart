import 'package:flutter/material.dart';

final ThemeData companyThemeData = new ThemeData(
  primaryColor: _Colors.primary,
  primaryColorBrightness: Brightness.dark,
  accentColor: _Colors.accent,
  accentColorBrightness: Brightness.dark,
  errorColor: _Colors.error,
);

// Colors to get from theme
extension myColorScheme on ColorScheme {
  Color get primary => _Colors.primary;
  Color get accent => _Colors.accent;
  Color get secondaryColor => _Colors.secondary;
  Color get background => _Colors.background;
  Color get error => _Colors.error;
  Color get textOnPrimary => _Colors.textOnPrimary;
  Color get text => _Colors.text;
  Color get disabledText => _Colors.disabledText;
  Color get inputBackground => _Colors.inputBackground;
}

// Theme colors
class _Colors {
  static const Color primary = const Color(0xFF3756F6);
  static const Color accent = const Color(0xFFFF3E3E);
  static const Color secondary = const Color(0xFFFBFBFB);
  static const Color background = const Color(0xFFFBFBFB);
  static const Color error = const Color(0xFFFF3E3E);
  static const Color textOnPrimary = const Color(0xFFFBFBFB);
  static const Color text = const Color(0xFF3D3D3D);
  static const Color disabledText = const Color(0xFF858585);
  static const Color inputBackground = const Color(0xFFF0F0F1);
}
