import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkAppTheme {
  // Colors for Dark Theme
  static const Color _primaryColor = Color.fromRGBO(147, 51, 234, 1);
  static const Color _secondaryColor = Color.fromRGBO(255, 99, 99, 1);
  static const Color _tertiaryColor = Color.fromRGBO(26, 35, 46, 1);
  static const Color _scaffoldBackgroundColor = Color(0xFF121212);
  static const Color _cardBackgroundColor = Color(0xFF1E1E1E);
  static const Color _disabledButtonColor = Color(0xFF424242);

  // Text Styles for Dark Theme
  static const _headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const _titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const _bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static const _bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const _titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const _titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white70,
  );

  static const _textTheme = TextTheme(
    headlineSmall: _headlineSmall,
    titleLarge: _titleLarge,
    bodyLarge: _bodyLarge,
    bodyMedium: _bodyMedium,
    titleMedium: _titleMedium,
    titleSmall: _titleSmall,
  );

  // App Bar Theme
  static const _appBarTheme = AppBarTheme(
    backgroundColor: _tertiaryColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

  // Input Decoration Theme
  static final _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: _cardBackgroundColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _secondaryColor),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    prefixIconColor: Colors.white70,
    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
    labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
  );

  // Elevated Button Theme
  final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return _disabledButtonColor;
        }
        return _primaryColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white38;
        }
        return Colors.white;
      }),
      fixedSize: WidgetStateProperty.all(
        const Size(double.infinity, 50),
      ),
      maximumSize: WidgetStateProperty.all(
        const Size.fromHeight(50),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevation: WidgetStateProperty.resolveWith<double>((states) {
        if (states.contains(WidgetState.disabled)) {
          return 0;
        }
        return 4;
      }),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  // Card Theme
  static final _cardTheme = CardTheme(
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: _cardBackgroundColor,
  );

  // Text Button Theme
  final _textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.white70),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
  );

  ThemeData get darkTheme => ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: _primaryColor,
          secondary: _secondaryColor,
          tertiary: _tertiaryColor,
          surface: _cardBackgroundColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(_textTheme),
        appBarTheme: _appBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        scaffoldBackgroundColor: _scaffoldBackgroundColor,
        cardTheme: _cardTheme,
        textButtonTheme: _textButtonTheme,
      );
}
