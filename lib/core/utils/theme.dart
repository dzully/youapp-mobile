import 'package:flutter/material.dart';

import '../constants/style_constants.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimaryColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: 'Inter',
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimaryColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    fontFamily: 'Inter',
  );
}
