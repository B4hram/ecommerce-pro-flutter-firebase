import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.indigo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
    ),
  );
}