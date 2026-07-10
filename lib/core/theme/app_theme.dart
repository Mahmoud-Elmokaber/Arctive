import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF050A14);
  static const Color surface = Color(0xFF0B1629);
  static const Color card = Color(0xFF0F172A);
  static const Color cardHover = Color(0xFF1E293B);
  static const Color accent = Color(0xFF38BDF8);
  static const Color accentDeep = Color(0xFF0284C7);
  static const Color text = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFCBD5E1);
  static const Color textMuted = Color(0xFF64748B);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color realEstate = Color(0xFF6366F1);
  static const Color legal = Color(0xFFF59E0B);
  static const Color medical = Color(0xFF10B981);
  static const Color engineering = Color(0xFFEC4899);

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    final colorScheme = base.colorScheme.copyWith(
      brightness: Brightness.dark,
      primary: accent,
      onPrimary: text,
      secondary: accentDeep,
      onSecondary: text,
      tertiary: engineering,
      onTertiary: text,
      surface: surface,
      onSurface: text,
      background: background,
      onBackground: text,
      error: error,
      onError: text,
      outline: textMuted,
      surfaceTint: accent,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      cardColor: card,
      dialogBackgroundColor: surface,
      dividerColor: textMuted.withOpacity(0.24),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: text,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        hintStyle: const TextStyle(color: textMuted),
        labelStyle: const TextStyle(color: textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: cardHover),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: cardHover),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: accent, width: 1.4),
        ),
      ),
      textTheme: base.textTheme.apply(bodyColor: text, displayColor: text),
      primaryTextTheme: base.primaryTextTheme.apply(
        bodyColor: text,
        displayColor: text,
      ),
      iconTheme: const IconThemeData(color: textSecondary),
      useMaterial3: true,
    );
  }
}
