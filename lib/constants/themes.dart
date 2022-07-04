import 'package:flutter/material.dart';

const Color primaryClr = Color(0xff2DA8FF);
const Color secondaryClr = Color(0xffB06AB3);
const Color backLight = Color(0xFFEEF2F5);
const Color backDark = Color(0xFF363947);
const Color grayShade = Color(0xff3A4750);
const Color white = Color(0xFFFFFFFF);

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
      primaryColor: primaryClr,
      backgroundColor: backLight,
      splashColor: primaryClr,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backLight,
      cardColor: white,
      appBarTheme: const AppBarTheme(
          elevation: 0, color: backLight, foregroundColor: Colors.black),
      colorScheme: const ColorScheme.light().copyWith(
        primary: primaryClr,
        secondary: secondaryClr,
        error: Colors.redAccent,
      ));
  static final darkTheme = ThemeData.dark().copyWith(
      shadowColor: primaryClr,
      primaryColor: primaryClr,
      backgroundColor: backDark,
      splashColor: primaryClr,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backDark,
      appBarTheme: const AppBarTheme(
          elevation: 0, color: backDark, foregroundColor: Colors.white),
      cardColor: grayShade,
      colorScheme: const ColorScheme.light().copyWith(
        primary: primaryClr,
        secondary: secondaryClr,
        error: Colors.redAccent,
      ));
}
