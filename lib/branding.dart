import 'package:flutter/material.dart';

const String appName = 'Skillbuilder';
const Color primaryColor = Color(0xFF0DC16A);
final ColorScheme appColorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
  primary: primaryColor,
);

final AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: appColorScheme.primary,
  foregroundColor: appColorScheme.onPrimary,
);
