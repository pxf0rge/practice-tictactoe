import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictatctoe/constants/colors.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgDeep,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.blue,
        surface: AppColors.boxGrey,
        onPrimary: AppColors.bgDeep,
        onSecondary: AppColors.bgDeep,
        onSurface: AppColors.grey,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.rajdhaniTextTheme(base.textTheme).apply(
        bodyColor: AppColors.grey,
        displayColor: AppColors.grey,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: AppColors.grey),
        titleTextStyle: GoogleFonts.orbitron(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          letterSpacing: 1.2,
          color: AppColors.grey,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accent.withValues(alpha: 0.7);
          }
          return AppColors.lightGrey.withValues(alpha: 0.35);
        }),
      ),
    );
  }

  static TextStyle get display => GoogleFonts.orbitron(
        fontWeight: FontWeight.w800,
        color: AppColors.grey,
        letterSpacing: 1.5,
      );

  static TextStyle get title => GoogleFonts.orbitron(
        fontWeight: FontWeight.w700,
        color: AppColors.grey,
        letterSpacing: 1.0,
      );

  static TextStyle get body => GoogleFonts.rajdhani(
        fontWeight: FontWeight.w600,
        color: AppColors.grey,
      );

  static TextStyle get muted => GoogleFonts.rajdhani(
        fontWeight: FontWeight.w500,
        color: AppColors.lightGrey,
      );
}
