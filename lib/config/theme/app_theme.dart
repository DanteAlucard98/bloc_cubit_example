import 'package:flutter/material.dart';

class AppTheme {
  static const seedColor = Colors.deepPurple;

  ThemeData getTheme() => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
    useMaterial3: true,
    listTileTheme: const ListTileThemeData(iconColor: seedColor),
  );
}
