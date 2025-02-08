import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color _primaryColor = Color.fromRGBO(75, 0, 110, 1);
  static const Color _secondaryColor = Colors.redAccent;
  static const Color _tertiaryColor = Color.fromRGBO(230, 247, 255, 1);
  static const Color _scaffoldBackgroundColor = Color(0xFFF3F4F6);
  static const Color _cardBackgroundColor = Colors.white;
  static const Color _disabledButtonColor = Colors.grey; // Added disabled color

  // Text Styles
  static const _headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: _primaryColor,
  );

  static const _titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: _primaryColor,
  );

  static const _bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const _bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const _titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const _titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
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
    backgroundColor: _primaryColor,
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
      borderSide: BorderSide(color: _primaryColor.withOpacity(0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _primaryColor.withOpacity(0.3)),
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
    prefixIconColor: _primaryColor,
  );

  // Elevated Button Theme
  final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return _disabledButtonColor; // Use grey for disabled state
        }
        return _primaryColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white70; // Slightly transparent white for disabled text
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
          return 0; // No elevation for disabled state
        }
        return 2;
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
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: _cardBackgroundColor,
  );

  // Text Button Theme
  final _textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(_primaryColor),
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

  ThemeData get lightTheme => ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: _primaryColor,
          secondary: _secondaryColor,
          tertiary: _tertiaryColor,
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
