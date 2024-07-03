import 'package:flutter/material.dart';
import 'package:wknd_app/config/theme/app_theme_extensions.dart';

abstract class AppTheme {
  Color get primary;

  ThemeData get themeData;

  Color get onPrimary;

  Color get secondary;

  Color get onSecondary;

  Color get errorColor;

  Color get cardColor;

  Color get scaffoldBackgroundColor;

  Color get tertiary;

  Color get onTertiary;

  TextTheme get textTheme;

  AppThemeExtension get extension;
}
