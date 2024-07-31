import 'package:flutter/material.dart';
import 'package:wknd_app/config/theme/app_theme.dart';
import 'package:wknd_app/config/theme/app_theme_extensions.dart';
import 'package:wknd_app/gen/fonts.gen.dart';

class AppLightTheme extends AppTheme {
  @override
  ThemeData get themeData => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: primary,
          seedColor: primary,
          onPrimary: onPrimary,
          secondary: secondary,
          onSecondary: onSecondary,
          error: errorColor,
          tertiary: tertiary,
          onTertiary: onTertiary,
        ),
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        dividerTheme: DividerThemeData(color: tertiary, thickness: .2),
        tabBarTheme: TabBarTheme(
          labelColor: primary,
          unselectedLabelColor: onSecondary ,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: onPrimary,
        ),
        textTheme: textTheme,
        cardColor: cardColor,
        cardTheme: CardTheme(color: cardColor, elevation: .1, margin: const EdgeInsets.symmetric(vertical: 10.0)),
        appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            foregroundColor: scaffoldBackgroundColor,
            backgroundColor: scaffoldBackgroundColor,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: primary,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: IconThemeData(color: primary)),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0), borderSide: const BorderSide(color: Colors.transparent, width: 0.0)),
          fillColor: cardColor,
          outlineBorder: BorderSide(color: secondary, width: 0.0),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          filled: true,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0), borderSide: BorderSide(color: primary, width: 1.0)),
          hintStyle: textTheme.bodyMedium?.copyWith(color: const Color(0xff837f77), fontSize: 16.0),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: textTheme.bodyMedium?.copyWith(color: primary),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0), borderSide: const BorderSide(color: Colors.transparent, width: 0.0)),
            fillColor: cardColor,
            outlineBorder: BorderSide(color: secondary, width: 0.0),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            filled: true,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0), borderSide: BorderSide(color: primary, width: 1.0)),
            hintStyle: textTheme.bodyMedium?.copyWith(color: const Color(0xff837f77), fontSize: 16.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(primary),
            foregroundColor: WidgetStateProperty.all<Color>(onPrimary),
            overlayColor: WidgetStateProperty.all<Color>(onPrimary.withOpacity(0.1)),
          ),
        ),
      );

  @override
  Color get cardColor => const Color(0xffF6F6F6);

  @override
  Color get errorColor => Colors.red;

  @override
  Color get onPrimary => const Color(0xffFFFFFF);

  @override
  Color get onSecondary => const Color(0xff0D0D0D);

  @override
  Color get primary => const Color(0xffFF6122);

  @override
  Color get scaffoldBackgroundColor => Colors.white;

  @override
  Color get secondary => Colors.white;

  @override
  TextTheme get textTheme => TextTheme(
        displayLarge: TextStyle(fontSize: 30.0, color: primary, fontFamily: FontFamily.anton),
        displayMedium: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        displaySmall: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: primary),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: tertiary),
        titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: tertiary),
        labelLarge: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        // bodyMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: primary), /// please don't use this because flutter used it as default
        bodySmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: primary),
        // bodyMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: primary),
      );

  @override
  Color get onTertiary => const Color(0xff0D0D0D);

  @override
  Color get tertiary => const Color(0xffFACF9F);

  @override
  AppThemeExtension get extension => AppThemeExtension(
        extraLightGrey: Colors.grey.withOpacity(0.3),
        lightGrey: Colors.grey.withOpacity(0.7),
      );
}
