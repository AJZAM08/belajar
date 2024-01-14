import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(12, 15, 39, 1),
    titleTextStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
  ),
  colorScheme: ColorScheme.dark(
    background: Color.fromRGBO(12, 15, 39, 1),
    primary: Color.fromRGBO(12, 15, 39, 1),
    secondary: Color.fromRGBO(12, 15, 39, 1),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color.fromRGBO(255, 255, 255, 1)),
  ),
);