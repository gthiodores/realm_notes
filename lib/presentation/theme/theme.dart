import 'package:flutter/material.dart';

const ColorScheme kColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.black,
  onPrimary: Colors.white,
  secondary: Colors.black54,
  onSecondary: Colors.white,
  error: Colors.redAccent,
  onError: Colors.white,
  background: Colors.white,
  onBackground: Colors.black54,
  surface: Colors.white,
  onSurface: Colors.black54,
);

const AppBarTheme kAppBarTheme = AppBarTheme(
  color: Colors.white,
  elevation: 0,
  actionsIconTheme: IconThemeData(color: Colors.black),
  iconTheme: IconThemeData(color: Colors.black),
);

final ElevatedButtonThemeData kElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);

final TextButtonThemeData kTextButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);
