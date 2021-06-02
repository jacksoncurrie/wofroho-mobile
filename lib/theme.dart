import 'package:flutter/material.dart';

final companyThemeData = ThemeData(
  primaryColor: _Colors.primary,
  primaryColorBrightness: Brightness.dark,
  accentColor: _Colors.primary,
  accentColorBrightness: Brightness.dark,
  errorColor: _Colors.error,
  fontFamily: 'Poppins',
);

// Colors to get from theme
extension myColorScheme on ColorScheme {
  Color get primaryColor => _Colors.primary;
  Color get accent => _Colors.accent;
  Color get secondaryColor => _Colors.secondary;
  Color get backgroundColor => _Colors.background;
  Color get errorColor => _Colors.error;
  Color get textOnPrimary => _Colors.textOnPrimary;
  Color get textOnSecondary => _Colors.primary;
  Color get text => _Colors.text;
  Color get disabledText => _Colors.disabledText;
  Color get inputBackground => _Colors.inputBackground;
  Color get emptyPhoto => _Colors.emptyPhoto;
  Color get darkBackground => _Colors.darkBackground;
}

// Theme colors
class _Colors {
  static const primary = const Color(0xFF3756F6);
  static const accent = const Color(0xFFEDD036);
  static const secondary = const Color(0xFFFBFBFB);
  static const background = const Color(0xFFFBFBFB);
  static const error = const Color(0xFFFF3E3E);
  static const textOnPrimary = const Color(0xFFFBFBFB);
  static const text = const Color(0xFF3D3D3D);
  static const disabledText = const Color(0xFF858585);
  static const inputBackground = const Color(0xFFF0F0F1);
  static const emptyPhoto = const Color(0xFFC4C4C4);
  static const darkBackground = const Color(0xFF3D3D3D);
}
