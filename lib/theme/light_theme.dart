import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Color.fromRGBO(12, 15, 39, 1)),
    titleTextStyle: TextStyle(color: Color.fromRGBO(12, 15, 39, 1)),
  ),
  colorScheme: ColorScheme.light(
    background: Color.fromRGBO(255, 255, 255, 1),
    primary: Color.fromRGBO(255, 255, 255, 1),
    secondary: Color.fromRGBO(255, 255, 255, 1),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color.fromRGBO(12, 15, 39, 1)),
  ),
);